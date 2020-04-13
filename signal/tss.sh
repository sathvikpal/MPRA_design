ml homer
mkdir -p ../../data/signal
annotatePeaks.pl tss /scratch/ref/homer/genomes/hg38/ -size 2000 -hist 1 -d $(ls -d ../../data/tags/*) > ../../data/signal/tss.hist
