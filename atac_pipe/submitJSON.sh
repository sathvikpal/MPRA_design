#!/bin/bash

mkdir -p "../../data/atac_output/${1}"
touch ../../data/atac_output/${1}/${1}.json

r1=`readlink -f ../../rawdata/fastq/${1}_1.fastq.gz;`
r2=`readlink -f ../../rawdata/fastq/${1}_2.fastq.gz;`
json=`readlink -f ../../data/atac_output/${1}/${1}.json;`

echo '{
    "atac.title" : "'$1'",
    "atac.description" : "First run",

    "atac.pipeline_type" : "atac",
    "atac.align_only" : false,
    "atac.true_rep_only" : false,

    "atac.genome_tsv" : "/scratch/jclab/sathvik/sathvik/MPRA_design/rawdata/genomes/hg19/hg19.tsv",

    "atac.paired_end" : true,

    "atac.fastqs_rep1_R1" : [ "'${r1}'" ],
    "atac.fastqs_rep1_R2" : [ "'${r2}'" ],

    "atac.auto_detect_adapter" : true,

    "atac.multimapping" : 4
}' > "../../data/atac_output/${1}/${1}.json"

cd "../../data/atac_output/${1}"

caper run ~/atac-seq-pipeline/atac.wdl -i ${json}
