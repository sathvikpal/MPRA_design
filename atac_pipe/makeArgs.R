c <- list.files(path = "../../data/fastq/", pattern = "_")
c <-sort(c)
args <- matrix(nrow = length(c)/2, ncol = 5)
for(i in 1:(length(c)/2))
{
  args[i,1] <- substr(c[i*2], 1, nchar(c[i*2])-11)
  args[i,2] <- paste0("/scratch/jclab/sathvik/sathvik/SNP_LDs/data/fastq/", c[i*2-1])
  args[i,3] <- paste0("/scratch/jclab/sathvik/sathvik/SNP_LDs/data/fastq/", c[i*2])
  args[i,4] <- paste0("/scratch/jclab/sathvik/sathvik/SNP_LDs/data/atac_pipe/", args[i,1])
  args[i,5] <- paste0(paste0(args[i,4], "/"), paste0(args[i,1], ".json"))
}

write.table(args, file = "makeJSON.args", quote = FALSE, row.names = FALSE, col.names = FALSE)

