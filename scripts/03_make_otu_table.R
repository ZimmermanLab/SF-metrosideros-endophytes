# R script to perform some ecological analyses on clustered data
# originating from single Sanger ITS reads

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017
# updated October 29, 2021

# load libraries
library("dplyr")
library("tidyr")
library("vegan")

# load files
otus <- read.table("output/mothur_pipeline/12_seq_with_OTU_ID.txt",
                   col.names = c("sequence_id",
                                 "otu_id"))

groups <- read.table("output/metadata_tables/groupfile.tsv",
                     col.names = c("sequence_id",
                                   "tree_id"))

trees <- read.csv("data/metadata/m_excel_tree_metadata_with_isolationfreq.csv",
                  stringsAsFactors = FALSE)

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


##########################################

# do and plot ordination with this matrix
plot(metaMDS(otu_table_trees), type = "t", display = "sites", cex = 1.5)

# fix row names to be more readable
row.names(otu_table_trees) <- c(paste("Balboa - Tree", 1:5),
                                paste("Downtown - Tree", 1:5),
                                paste("Mt. Davidson - Tree", 1:5),
                                paste("Bay - Tree", 1:5),
                                paste("Freeway - Tree", 1:5),
                                paste("Ocean - Tree", 1:5))


# save a pdf of the rarefaction curve
pdf("figures/prelim_rarecurve.pdf")
rare_color <- c(rep("#ff5e62", 5),
                rep("#f0a200", 5),
                rep("#007f36", 5),
                rep("#8781e6", 5),
                rep("#00005a", 5),
                rep("#81005e", 5))

group_labels <- c(rep("Balboa", 5),
                  rep("Downtown", 5),
                  rep("Mt. Davidson", 5),
                  rep("Bay", 5),
                  rep("Freeway", 5),
                  rep("Ocean", 5))

rarecurve(otu_table_trees,
          main = "Species accumulation curves for endophytic fungi",
          col = rare_color,
          label = FALSE,
          lwd = 2.5,
          xlab = "Number of fungal isolates",
          ylab = "Number of fungal species (97% ITS OTUs)",
          cex.lab = 1.4,
          cex.main = 1.65)

legend("bottomright",
       legend = levels(factor(group_labels)),
       pch = 16,
       cex = 1,
       pt.cex = 2,
       col = c(rep("#ff5e62"),
               rep("#8781e6"),
               rep("#f0a200"),
               rep("#00005a"),
               rep("#007f36"),
               rep("#81005e")))
dev.off()



# some more species accumulation curves
plot(colSums(otu_table_sites))
plot(specaccum(otu_table_sites, method = "rare"), xvar = "individuals")
