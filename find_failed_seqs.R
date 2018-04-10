# Draft of R script to perform some ecological analyses on clustered data
# originating from single Sanger ITS reads

# Originally written by Emma Gibson
# egibson@dons.usfca.edu
# April 5, 2018

library(seqinr)
library(dplyr)

culturing <- read.csv("metadata/culturing_worksheet.csv")
extractions <- read.csv("metadata/Extraction_worksheet.csv")
trees <- read.csv("metadata/M_excel_tree_metadata.csv")
water_voucher <- read.csv("metadata/Water_Voucher_Worksheet.csv")
extraction_with_tree <- read.table("groupfile.tsv",
                                   sep = "\t",
                                   col.names = c("Extraction_ID", "Tree_ID"))

hand_fasta_in <- read.fasta("hand-cleaned_seqs/hand-cleaned_seqs.fasta")
seq_names <- names(hand_fasta_in)
failed_seqs <- seq_names[grepl(pattern = "_failed", seq_names)]
failed_seqs <- failed_seqs[grepl(pattern = "EUSF", failed_seqs)]
failed_seqs_names_only <- gsub("_ITS1F_[A-H][0-9]+_failed.ab1", "", failed_seqs)
failed_seqs_names_only <- gsub("EUSF", "EUSF0", failed_seqs_names_only)
extraction_with_tree$Extraction_ID <- gsub("EUSF", "EUSF0",
                                           extraction_with_tree$Extraction_ID)

failed_seqs_matched_vouchers <- extractions %>%
  filter(Label_ID %in% failed_seqs_names_only) %>%
  select(Label_ID, Culture_Label_ID) %>%
  right_join(water_voucher, by = c("Culture_Label_ID" = "Label_ID_culture")) %>%
  select(Label_ID, Culture_Label_ID, Label_ID_Voucher) %>%
  na.omit() %>%
  left_join(extraction_with_tree, by = c("Label_ID" = "Extraction_ID"))


write.csv(failed_seqs_matched_vouchers,
          file = "metadata/failed_seqs_with_voucher_ID.csv",
          row.names = FALSE)

summary(factor(failed_seqs_matched_vouchers$Tree_ID))
