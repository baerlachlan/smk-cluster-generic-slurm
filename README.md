# Snakemake profile for Slurm execution

My personal config for slurm execution of snakemake workflows.

Requires minumum Snakemake version 8.

This setup originated from John Blischak's [smk-simple-slurm](https://github.com/jdblischak/smk-simple-slurm) but has been modified over several years and Snakemake versions.

## Usage

Add the profile to your user configuration directory:

```bash
mkdir -p ~/.config/snakemake
cd ~/.config/snakemake
git clone git@github.com:baerlachlan/smk-profile-slurm.git
```

Pass the folder name when executing Snakemake:

```bash
snakemake --profile smk-profile-slurm
```

Optionally, set the default profile in your `~/.bashrc` and omit the `--profile` argument:

```
export SNAKEMAKE_PROFILE=smk-profile-slurm
```
