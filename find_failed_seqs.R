# Draft of R script to perform some ecological analyses on clustered data
# originating from single Sanger ITS reads

# Originally written by Emma Gibson
# egibson@dons.usfca.edu
# April 5, 2018

library(seqinr)
hand_fasta_in <- read.fasta("hand-cleaned_seqs/hand-cleaned_seqs.fasta")
seq_names <- names(hand_fasta_in)
failed_seqs <- seq_names[grepl(pattern = "_failed", seq_names)]
failed_seqs <- failed_seqs[grepl(pattern = "EUSF", failed_seqs)]
failed_seqs_names_only <- gsub("_ITS1F_[A-H][0-9]+_failed.ab1","",failed_seqs)
