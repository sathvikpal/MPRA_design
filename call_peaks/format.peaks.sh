ml bedtools
mkdir -p ../../data/peaks/formattedpeaks

for i in $(ls ../../data/peaks/*summits.bed)
do
  cat $i | sort -grk5 | head -100000 | awk '{print $1, $2-99, $3+100, $4, $5}' | awk '{if ($2 < 0) print $1, 0, $3, $4, $5; else print $0}' | tr " " "\t" | intersectBed -a - -b /scratch/jclab/sathvik/sathvik/MPRA_design/rawdata/genomes/UCSC/hg38/hg38.chrom.sizes.bed | sortBed -i - > $(echo $i | sed 's/bed/100k.200bp.bed/' | sed 's/\/peaks/\/peaks\/formattedpeaks\//g' )
done
