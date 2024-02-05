# Snakemake profile for Slurm execution

My personal config for slurm execution of snakemake workflows.

Requires minimum Snakemake version 8.

This setup originated from John Blischak's [smk-simple-slurm](https://github.com/jdblischak/smk-simple-slurm), but has been modified over several years and Snakemake versions.

## Setup

Add the profile to your user configuration directory:

```bash
mkdir -p ~/.config/snakemake
cd ~/.config/snakemake
git clone git@github.com:baerlachlan/smk-profile-slurm.git
```

Modify the account and partition parameters to the `sbatch` command in `config.v8+.yaml` under the `cluster-generic-submit-cmd` option.

Also modify the `wrapper-prefix` option if you intend to use snakemake wrappers stored locally (this is my strategy for using wrappers on compute nodes with no internet).

## Usage

Pass the folder name when executing Snakemake:

```bash
snakemake --profile smk-profile-slurm
```

Optionally, set the default profile in your `~/.bashrc` and omit the `--profile` argument:

```bash
echo "export SNAKEMAKE_PROFILE=smk-profile-slurm" >> ~/.bashrc
snakemake
```
