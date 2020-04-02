#!/usr/bin/env bash
#SBATCH --mem 4GB
#SBATCH -t 6:00:00
#SBATCH --array=1

conda init bash
conda activate encode-atac-seq-pipeline 

bash submitJSON.sh $(sed -n "${SLURM_ARRAY_TASK_ID}p" submitJSON.args)
