#!/usr/bin/env bash
#SBATCH --mem 24G
#SBATCH --array=2-176

bash tags.sh $(sed -n "${SLURM_ARRAY_TASK_ID}p" tags.args)
