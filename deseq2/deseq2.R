library(ggplot2)
library(DESeq2)
library(plyr)
library(reshape2)
library(data.table)

read_dat_filename <- function(filename){
  dat <- fread(filename, skip=1, header=F)
  dat$Source <- filename
  dat
}

file.list <- list.files(path="../../data/deseq2", pattern=".Counts$", full=T)

x <- ldply(file.list, read_dat_filename)

x.m <- melt(x[,c("V4", "V6", "Source")], id.vars=c("V4", "Source"))

x.c <- dcast(x.m, V4~Source)

row.names(x.c) <- x.c$V4

countData <- x.c[,2:ncol(x.c)]

colData <- data.frame("id"=names(countData))

colData$rawCounts <- gsub(".*\\/", "", colData$id)
colData$bam <- gsub(".rawCounts", "", colData$rawCounts)

brain <- read.delim("/scratch/jclab/sathvik/sathvik/MPRA_design/rawdata/encode_bam/brain/?type=Experiment&files.output_type=alignments&files.assembly=GRCh38&files.status=released")
heart <- read.delim("/scratch/jclab/sathvik/sathvik/MPRA_design/rawdata/encode_bam/heart/?type=Experiment&files.output_type=alignments&files.file_type=bam&files.assembly=GRCh38&files.status=released")
other_tissues <- read.delim("/scratch/jclab/sathvik/sathvik/MPRA_design/rawdata/encode_bam/other_tissues/?type=Experiment&files.output_type=alignments&files.file_type=bam&files.assembly=GRCh38&files.status=released")
metadata <- rbind(rbind(brain, heart),other_tissues)

tissue <- vector(mode = "character", length=length(colData$bam))
j=1
for(i in colData$bam){
tissue[j] <- as.character(metadata$Biosample.term.name[metadata$File.accession == i])
if(tissue[j] != "heart" && tissue[j] != "brain"){
tissue[j] <- "other"
}
j <- j+1
}
colData$tissue <- tissue

group <- vector(mode = "character", length=length(colData$bam))
for(i in 1:length(group)){
if(tissue[i] != "heart"){
group[i] <- "control"
}
else{
group[i] <- "heart"
}
}
colData$group <- factor(group)

dds <- DESeqDataSetFromMatrix(countData = countData, colData=colData, design =~ group)

dds <- DESeq(dds)

res <- results(dds, lfcThreshold=log2(3), altHypothesis="greater", contrast=c("group", "heart", "control"))

res <- data.frame(res)

#x.counts <- data.frame(counts(dds, normalize=T))

#names(x.counts)  <- gsub(".peakUnion.rawCounts", "", gsub(".*deseq2.", "", names(x.counts)))

#res <- merge (res, x.counts, by="row.names")

res <- res[order(res$padj),]

write.csv(file="../../data/deseq2/res.heart.fc3.csv", res, row.names=F)


res <- results(dds, lfcThreshold=log2(2), altHypothesis="greater", contrast=c("group", "heart", "control"))

res <- data.frame(res)

#x.counts <- data.frame(counts(dds, normalize=T))

#names(x.counts)  <- gsub(".peakUnion.rawCounts", "", gsub(".*deseq2.", "", names(x.counts)))

#res <- merge (res, x.counts, by="row.names")

res <- res[order(res$padj),]

write.csv(file="../../data/deseq2/res.heart.fc2.csv", res, row.names=F)


res <- results(dds, lfcThreshold=log2(4), altHypothesis="greater", contrast=c("group", "heart", "control"))

res <- data.frame(res)

#x.counts <- data.frame(counts(dds, normalize=T))

#names(x.counts)  <- gsub(".peakUnion.rawCounts", "", gsub(".*deseq2.", "", names(x.counts)))

#res <- merge (res, x.counts, by="row.names")

res <- res[order(res$padj),]

write.csv(file="../../data/deseq2/res.heart.fc4.csv", res, row.names=F)
