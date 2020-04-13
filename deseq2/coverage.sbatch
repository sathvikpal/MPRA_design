#!/usr/bin/env bash
#SBATCH --mem 32G
#SBATCH --array=2-176

bash coverage.sh $(sed -n "${SLURM_ARRAY_TASK_ID}p" coverage.args)
