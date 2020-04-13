#!/usr/bin/env bash
#SBATCH --mem 26G
#SBATCH --array=2-176

bash macs2.sh $(sed -n "${SLURM_ARRAY_TASK_ID}p" macs2.args)
