# R script to perform some ecological analyses on clustered data
# originating from single Sanger ITS reads

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017
# updated October 29, 2021

# load files
otus <- read.table("output/mothur_pipeline/12_seq_with_OTU_ID.txt",
                   col.names = c("sequence_id",
                                 "otu_id"))

groups <- read.table("output/metadata_tables/groupfile.tsv",
                     col.names = c("sequence_id",
                                   "tree_id"))

trees <- read.csv("data/metadata/m_excel_tree_metadata_with_isolationfreq.csv",
                  stringsAsFactors = FALSE)

tbas <- read.csv("data/metadata/tbas_taxonomies.csv")

# make a subset that only contains trees from the second round of sampling
# so all are comparable
trees <- subset(trees,
                as.POSIXct(trees$Date_sampled) > as.POSIXct("2017-08-01"))

# otu table by trees
otu_table_trees <- otus %>%
  inner_join(groups, by = c("sequence_id" = "sequence_id")) %>%
  group_by(tree_id, otu_id) %>%
  summarize(count = n()) %>%
  spread(otu_id, count, fill = 0)

# fix row name problems for vegan
otu_table_trees_ids <- otu_table_trees$tree_id
otu_table_trees <- subset(otu_table_trees, select = -tree_id)
row.names(otu_table_trees) <- otu_table_trees_ids

# error if any trees or OTUs are lacking sequences
stopifnot(all(rowSums(otu_table_trees)))
stopifnot(all(colSums(otu_table_trees)))

otu_table_sites <- otus %>%
  inner_join(groups, by = c("sequence_id" = "sequence_id")) %>%
  mutate(site_id = gsub("T[0-9]", "", tree_id)) %>%
  group_by(otu_id, site_id) %>%
  summarize(count = n()) %>%
  spread(otu_id, count, fill = 0)

# fix row name problems for vegan
otu_table_site_ids <- otu_table_sites$site_id
otu_table_sites <- subset(otu_table_sites, select = -site_id)
row.names(otu_table_sites) <- otu_table_site_ids

# error if any sites or OTUs are lacking sequences
stopifnot(all(rowSums(otu_table_sites)))
stopifnot(all(colSums(otu_table_sites)))
