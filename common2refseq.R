#!/usr/bin/R
if (!require("magrittr")) install.packages("magrittr")
# For Drosophila melanogaster
# takes a 3 or 12 column BED file and converts from NCBI "Common" format (i.e. chr4 or 4 to RefSeq chrom names).
# warning: does not include unassembled contigs.
# Usage: "Rscript common2refseq.R [bedfile]

`%>%` <- magrittr::`%>%`
args = commandArgs(trailingOnly=TRUE)
if(length(args) == 0){
	stop("Please supply an input BED file", call.=FALSE)
}

bed <- read.table(args[1], header = FALSE, sep = "\t")

write.table(bed, file = "sanity_check", quote = FALSE, row.names = FALSE, sep = "\t")
common <- c("X", "Y", "2L", "2R" , "3L", "3R", "4", "chrX", "chrY", "chr2L", "chr2R","chr3L", "chr3R", "chr4")

refseq <- c('NC_004354.4', 'NC_024512.1', 'NT_033779.5', 'NT_033778.4', 'NT_037436.4', 'NT_033777.3','NC_004353.4', 'NC_004354.4', 'NC_024512.1', 'NT_033779.5', 'NT_033778.4', 'NT_037436.4', 'NT_033777.3','NC_004353.4' )

dat <- data.frame(V1 = common, V2 = refseq)

merged <- merge(bed, dat, c('V1')) %>% dplyr::select(-c(V1))

write.table(merged, file = "merged.txt", quote = FALSE, row.names = FALSE, sep = "\t")

if(ncol(merged) < 4){
	final <- merged[, c(3,1,2)]
} else {
	final <- merged[, c(12,1,2,3,4,5,6,7,8,9,10,11)]
}

write.table(final, file = paste0(args[1], "_conv.txt"), quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t")


