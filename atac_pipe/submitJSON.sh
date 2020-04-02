#!/bin/bash
tmpfile="$(mktemp)"

mkdir -p "../../data/atac_output/${1}"

r1=`cd ../../rawdata/fastq/${1}_1.fastq.gz; pwd`
r2=`cd ../../rawdata/fastq/${1}_2.fastq.gz; pwd`

echo '{
    "atac.title" : "'$1'",
    "atac.description" : "First run",

    "atac.pipeline_type" : "atac",
    "atac.align_only" : false,
    "atac.true_rep_only" : false,

    "atac.genome_tsv" : "/scratch/jclab/sathvik/sathvik/SNP_LDs/data/hg19/hg19.tsv",

    "atac.paired_end" : true,

    "atac.fastqs_rep1_R1" : [ "'${r1}'" ],
    "atac.fastqs_rep1_R2" : [ "'${r2}'" ],

    "atac.auto_detect_adapter" : true,

    "atac.multimapping" : 4
}' > ${tmpfile}

cd "../../data/atac_output/${1}"

conda init bash
conda activate encode-atac-seq-pipeline

caper run ~/atac-seq-pipeline/atac.wdl -i ${tmpfile}
rm ${tmpfile}
