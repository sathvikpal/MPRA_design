
# Installation only needs to be done once on R version greater than 3.4.3
# install.packages("LDlinkR")
library("LDlinkR")

# Token for API
# 920cb18edc6e

# Import list of SNPs from Joe
list_of_query_snps <- read.table("../data/heart_list.txt", col.names = FALSE, stringsAsFactors = FALSE)[,1]

# Redefine the LDproxy_batch function to have error handling
LDproxy_batch_with_error_handle <- function (snp, pop = "CEU", r2d = "r2", token = NULL, append = FALSE)
{
  snp <- as.data.frame(snp)
  if (append == FALSE) {
    for (i in 1:nrow(snp)) {
      myfile <- paste(snp[i, ], ".txt", sep = "")
      df_proxy <- LDproxy(snp = snp[i, ], pop, r2d, token)
      write.table(df_proxy, file = myfile, append = FALSE,
                  quote = FALSE, row.names = TRUE, sep = "\t")
    }
  }
  else if (append == TRUE) {
    for (i in 1:nrow(snp)) {
      df_proxy <- LDproxy(snp = snp[i, ], pop, r2d, token)
      df_proxy["query_snp"] <- rep(snp[i, ], nrow(df_proxy))
      df_proxy <- try(df_proxy[, colnames(df_proxy)[c(11, 1:10)]])
      try(write.table(df_proxy, file = "../data/heart_linked_snps.txt",
                      append = TRUE, quote = FALSE, row.names = TRUE,
                      col.names = !file.exists("../data/heart_linked_snps.txt"),
                      sep = "\t"))
    }
  }
}

# Batch download
LDproxy_batch_with_error_handle(list_of_query_snps, pop = "EUR", token = "920cb18edc6e", append = TRUE)


