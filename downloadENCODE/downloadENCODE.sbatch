#!/usr/bin/env bash
#SBATCH --mem 8GB
#SBATCH -t 6:00:00
#SBATCH --array=2

bash downloadENCODE.sh $(sed -n "${SLURM_ARRAY_TASK_ID}p" downloadENCODE.args)
