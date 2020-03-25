cd $4
conda activate encode-atac-seq-pipeline 
sbatch -J "${1}" --export=ALL --mem 3G -t 4-0 --wrap "caper run ~/atac-seq-pipeline/atac.wdl -i '$5'"
