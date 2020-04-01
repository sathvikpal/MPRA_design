#!/usr/bin/env bash
#SBATCH --mem 4GB
#SBATCH -t 6:00:00
#SBATCH --array=

bash downloadENCODE.sh $(sed -n "${SLURM_ARRAY_TASK_ID}p" downloadENCODE.args)
