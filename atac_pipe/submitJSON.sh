tmpfile=$(mktemp /tmp/json.XXXXXX)
exec 3>"$tmpfile"
r1="../../rawdata/fastq/${1}_1.fastq.gz"
r2="../../rawdata/fastq/${1}_2.fastq.gz"
mkdir -p "../../data/atac_ouput/${1}"

echo '{
    "atac.title" : "'$1'",
    "atac.description" : "First run",

    "atac.pipeline_type" : "atac",
    "atac.align_only" : false,
    "atac.true_rep_only" : false,

    "atac.genome_tsv" : "/scratch/jclab/sathvik/sathvik/SNP_LDs/data/hg19/hg19.tsv",

    "atac.paired_end" : true,

    "atac.fastqs_rep1_R1" : [ "'${r1}'" ],
    "atac.fastqs_rep1_R2" : [ "'${r2}" ],

    "atac.auto_detect_adapter" : true,

    "atac.multimapping" : 4
}' > ${tmpfile}

cd "../../data/atac_ouput/${1}"
conda activate encode-atac-seq-pipeline 
sbatch -J "${1}" --export=ALL --mem 3G -t 4-0 --wrap "caper run ~/atac-seq-pipeline/atac.wdl -i '${tmpfile}'"
rm "$tmpfile"