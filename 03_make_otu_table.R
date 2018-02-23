# Draft of R script to perform some ecological analyses on clustered data
# originating from single Sanger ITS reads

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017

## TODO: Fix paths for the files

# load libraries
library("dplyr")
library("tidyr")
library("vegan")

# load files
otus <- read.table("seq_with_OTU_ID.txt")
groups <- read.table("groupfile.tsv")
trees <- read.csv("metadata/M_excel_tree_metadata.csv",
                  stringsAsFactors = FALSE)

# count by groups instead of trees
otu_table <- otus %>%
  left_join(groups, by = c("V1" = "V1")) %>%
  group_by(V2.x, V2.y) %>%
  summarize(count = n()) %>%
  spread(V2.x, count, fill = 0)

# get rid of rows with NA
otu_table <- as.data.frame(na.omit(otu_table))

# fix row name problems for vegan
row.names(otu_table) <- otu_table[, 1]
otu_table <- otu_table[, -1]

# drop out USF test sample
otu_table <- otu_table[1:12,]

# do and plot ordination with this matrix
plot(metaMDS(otu_table), type = "t", display = "sites", cex = 1.5)

# fix row names to be more readable
#row.names(otu_table) <- c(paste("Balboa - Tree", 1:4),
                         paste("Downtown - Tree", 1:4),
                         paste("Mt. Davidson - Tree", 1:4),
                         "USF")

# some species accumulation curves
rarecurve(otu_table, main = "Species accumulation curves for endophytic fungi")
plot(colSums(otu_table))
plot(specaccum(otu_table, method = "rare"), xvar = "individuals")

# more sophisticaed multi-step ordination plotting
ord_obj <- metaMDS(otu_table)

group_labels <- c(rep("Balboa", 4), rep("Downtown", 4), rep("Mt. Davidson", 4), "USF")

plot(ord_obj,
     display = "sites",
     type = "n",
     main = "NMDS ordination of fungal community composition")

points(ord_obj,
       display = "sites",
       col = c(rep("blue", 4),
                 rep("red", 4),
                 rep("orange", 4),
                 "black"),
       cex = 4,
       pch = 16)

legend("bottomleft",
       legend = levels(factor(group_labels)),
       pch = 16,
       cex = 1.2,
       pt.cex = 2.7,
       col = c("blue",
               "red",
               "orange",
               "black"))

ordiellipse(ord_obj,
            groups =group_labels,
            label = FALSE,
            col = c("blue",
                    "red",
                    "orange",
                    "black"),
            lwd = 10)

