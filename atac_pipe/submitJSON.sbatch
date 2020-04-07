#!/bin/bash
#SBATCH --mem 4GB
#SBATCH -t 4-0
#SBATCH --array=1

conda activate encode-atac-seq-pipeline
bash submitJSON.sh $(sed -n "${SLURM_ARRAY_TASK_ID}p" submitJSON.args)
