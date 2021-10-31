# R script to perform some cleaning on taxonomic assignments from T-BAS

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# October 31, 2021

extraction_with_tree <- read.table(
  "output/metadata_tables/groupfile.tsv",
  sep = "\t",
  col.names = c("extraction_id", "tree_id")) %>%
  mutate(site_id = substr(tree_id, 1, 2))

tbas <- read.csv("data/metadata/tbas_taxonomies.csv")

tbas_with_site <- tbas %>%
  mutate(extraction_id = substr(Query_sequence, 1, 8)) %>%
  mutate(extraction_id = gsub(x = extraction_id,
                              pattern = "EUSF",
                              replacement = "EUSF0")) %>%
  left_join(extraction_with_tree, by = "extraction_id")

# both non-identified sequences are identical and from a single OTU
# sequence ids EUSF00620 and EUSF00664
# best named match is to Smardaea australis
# (Ascomycota,  Pezizales,  Pyronemataceae)  
# reference article: https://www.jstor.org/stable/26662853
# see also blastn alignments in data/blast_results_for_unknowns directory

tbas_with_site$Class.level_assignment[
  tbas_with_site$extraction_id == "EUSF00620"] <- "Pezizomycetes"

tbas_with_site$Order.level_assignment[
  tbas_with_site$extraction_id == "EUSF00620"] <- "Pezizales"

tbas_with_site$Class.level_assignment[
  tbas_with_site$extraction_id == "EUSF00664"] <- "Pezizomycetes"

tbas_with_site$Order.level_assignment[
  tbas_with_site$extraction_id == "EUSF00664"] <- "Pezizales"

write.csv(tbas_with_site,
          file = "output/metadata_tables/tbas_with_site.csv",
          row.names = FALSE)