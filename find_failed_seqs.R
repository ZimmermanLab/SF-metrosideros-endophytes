
library(seqinr)
fasta_in <- read.fasta("data/preliminary_trimmed_seqs.fasta")
seq_names <- names(fasta_in)
failed_seqs <- seq_names[grepl(pattern = "_A10", seq_names)]

#gsub - cleans out info you don't need
