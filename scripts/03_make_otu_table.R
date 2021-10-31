# Draft of R script to perform some ecological analyses on clustered data
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
otus <- read.table("output/mothur_pipeline/08_seq_with_OTU_ID.txt",
                   col.names = c("sequence_id",
                                 "otu_id"))

groups <- read.table("output/metadata_tables/groupfile.tsv",
                     col.names = c("sequence_id",
                                   "tree_id"))

trees <- read.csv("data/metadata/m_excel_tree_metadata_with_isolationfreq.csv",
                  stringsAsFactors = FALSE)

# count by groups instead of trees
# FIXME this is by trees though?
otu_table <- otus %>%
  left_join(groups, by = c("sequence_id" = "sequence_id")) %>%
  group_by(tree_id, otu_id) %>%
  summarize(count = n()) %>%
  spread(otu_id, count, fill = 0) %>%
  filter(grepl(tree_id, pattern = "^S"))

# get rid of rows with NA
otu_table <- as.data.frame(na.omit(otu_table))

# fix row name problems for vegan
row.names(otu_table) <- otu_table[, 1]
otu_table <- otu_table[, -1]

# Get rid of OTUs without sequences
otu_table <- otu_table[, colSums(otu_table) > 0]

# do and plot ordination with this matrix
plot(metaMDS(otu_table), type = "t", display = "sites", cex = 1.5)

# fix row names to be more readable
row.names(otu_table) <- c(paste("Balboa - Tree", 1:5),
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

rarecurve(otu_table,
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

# save a pdf of a rarefaction curve with one line per site
pdf("figures/prelim_rarecurve_combined.pdf")
rare_color_c <- c(rep("#ff5e62"),
                  rep("#f0a200"),
                  rep("#007f36"),
                  rep("#8781e6"),
                  rep("#00005a"),
                  rep("#81005e"))

group_labels_c <- c(rep("Balboa"),
                  rep("Downtown"),
                  rep("Mt. Davidson"),
                  rep("Bay"),
                  rep("Freeway"),
                  rep("Ocean"))

otu_table_combined <- otus %>%
  left_join(groups, by = c("sequence_id" = "sequence_id")) %>%
  mutate(site_id = gsub("T[0-9]", "", tree_id)) %>%
  group_by(otu_id, site_id) %>%
  summarize(count = n()) %>%
  spread(otu_id, count, fill = 0)

otu_table_combined <- as.data.frame(na.omit(otu_table_combined))

row.names(otu_table_combined) <- otu_table_combined[, 1]
otu_table_combined <- otu_table_combined[, -1]

rarecurve(otu_table_combined,
          main = "Species accumulation curves for endophytic fungi",
          col = rare_color_c,
          label = FALSE,
          lwd = 7,
          xlab = "Number of fungal isolates",
          ylab = "Number of fungal species (97% ITS OTUs)",
          cex.lab = 1.4,
          cex.main = 1.65)

legend("bottomright",
       legend = levels(factor(group_labels_c)),
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
plot(colSums(otu_table))
plot(specaccum(otu_table, method = "rare"), xvar = "individuals")


# more sophisticaed multi-step ordination plotting
ord_obj <- metaMDS(otu_table, trymax = 100)

#make a subset that only containt trees from the second round of sampling
trees_aug <- subset(trees,
                    as.POSIXct(trees$Date_sampled) > as.POSIXct("2017-08-01"))

adonis(otu_table ~ trees_aug$Site_ID)


pdf("figures/prelim_ordination_proper_color_no-DBH.pdf")
plot(ord_obj,
     display = "sites",
     type = "n",
     main = "NMDS ordination of fungal community composition",
     cex.main = 1.6,
     xlab = "",
     ylab = "",
     tck = 0,
     labels = FALSE)

points(ord_obj,
       display = "sites",
       col = c(rep("#ff5e62", 5),
               rep("#f0a200", 5),
               rep("#007f36", 5),
               rep("#8781e6", 5),
               rep("#00005a", 5),
               rep("#81005e", 5)),
       cex = 25 / 10, # comment out to remove dbh sizing
       pch = 16)

legend("bottomleft",
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

ordiellipse(ord_obj,
            groups = group_labels,
            label = FALSE,
            col = c(rep("#ff5e62"),
                    rep("#8781e6"),
                    rep("#f0a200"),
                    rep("#00005a"),
                    rep("#007f36"),
                    rep("#81005e")),
            lwd = 7)
dev.off()

