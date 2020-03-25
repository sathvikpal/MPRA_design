mkdir $4

echo '{
    "atac.title" : "'$1'",
    "atac.description" : "First run",

    "atac.pipeline_type" : "atac",
    "atac.align_only" : false,
    "atac.true_rep_only" : false,

    "atac.genome_tsv" : "/scratch/jclab/sathvik/sathvik/SNP_LDs/data/hg19/hg19.tsv",

    "atac.paired_end" : true,

    "atac.fastqs_rep1_R1" : [ "'$2'" ],
    "atac.fastqs_rep1_R2" : [ "'$3'" ],

    "atac.auto_detect_adapter" : true,

    "atac.multimapping" : 4
}' > $5
