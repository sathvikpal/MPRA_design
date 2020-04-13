ml bedtools

mkdir -p ../../data/deseq2

NAME="$(echo $1 | grep -Eo "\w{11}.bam" | cut -c 1-11)"
RAWCOUNT="../../data/deseq2/${NAME}.rawCounts"

coverageBed -sorted -counts -g /scratch/jclab/sathvik/sathvik/MPRA_design/rawdata/genomes/hg38/hg38.chrom.sizes -a ../../data/peaks/peak.union.sort.bed -b $1 > ${RAWCOUNT}
