#!/usr/bin/env bash

## Check status of Slurm job

jobid="$1"

if [[ "$jobid" == Submitted ]]
then
  echo smk-simple-slurm: Invalid job ID: "$jobid" >&2
  echo smk-simple-slurm: Did you remember to add the flag --parsable to your sbatch call? >&2
  exit 1
fi

## Generic retry function with up to 5 retry attempts
## Credit to Nathan Watson-Haigh (GitHub: @nathanhaigh)
function retry {
  local max_attempts=5
  local delay_sec=30

  local attempt=1
  while true; do
    "$@" && break || {
      if [[ ${attempt} -lt ${max_attempts} ]]; then
        >&2 echo "WARN: Command ($@) failed attempt ${attempt} of ${max_attempts}:"
        sleep ${delay_sec}
      else
        >&2 echo "ERROR: Command ($@) failed after ${attempt} attempt(s)."
        exit 1
      fi
      ((attempt++))
    }
  done
}

output=`retry sacct -j "$jobid" --format State --noheader | head -n 1 | awk '{print $1}'`

if [[ $output =~ ^(COMPLETED).* ]]
then
  echo success
elif [[ $output =~ ^(RUNNING|PENDING|COMPLETING|CONFIGURING|SUSPENDED).* ]]
then
  echo running
## If sacct returns empty output, assume it's temporary and return "running"
## This can happen when a job is recently submitted and the database is slow to update
elif [[ -z $output ]]
then
  echo running
else
  echo failed
fi