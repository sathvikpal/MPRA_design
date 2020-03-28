#!/usr/bin/env bash
#SBATCH --mem 8GB
#SBATCH -t 0
#SBATCH --array=1-113

ml sratoolkit
mkdir -p ../../rawdata/fastq

SRR_ID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" listOfBrainATAC.args)
SRA="/scratch/jclab/sathvik/sathvik/tmp/sra/${SRR_ID}.sra"
echo '/repository/user/main/public/root = "/scratch/jclab/sathvik/sathvik/tmp"' > ~/.ncbi/user-settings.mkfg

prefetch ${SRR_ID}

cd ../../rawdata/fastq
fastq-dump --split-files $SRA