#!/usr/bin/env bash
#SBATCH --mem 4GB
#SBATCH -t 0
#SBATCH --array=1-112

ml sratoolkit

echo '/repository/user/main/public/root = "/scratch/jclab/sathvik/sathvik/tmp"' > ~/.ncbi/user-settings.mkfg
fastq-dump --split-3 --gzip -O ../../data/fastq $(sed -n "${SLURM_ARRAY_TASK_ID}p" sra.args)
