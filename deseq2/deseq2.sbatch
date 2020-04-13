#!/usr/bin/env bash
#SBATCH --mem 200G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12

bash deseq2.sh
