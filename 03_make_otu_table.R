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
otu_table <- otu_table[1:30,]

# do and plot ordination with this matrix
plot(metaMDS(otu_table), type = "t", display = "sites", cex = 1.5)

# fix row names to be more readable
row.names(otu_table) <- c(paste("Balboa - Tree", 1:5),
                         paste("Downtown - Tree", 1:5),
                         paste("Mt. Davidson - Tree", 1:5),
                         paste("Bay - Tree", 1:5),
                         paste("Freeway - Tree", 1:5),
                         paste("Ocean - Tree", 1:5))


#save a pdf of the rarefaction curve
pdf("figures/prelim_rarecurve.pdf")
rarecurve(otu_table, main = "Species accumulation curves for endophytic fungi")
dev.off()

# some more species accumulation curves
plot(colSums(otu_table))
plot(specaccum(otu_table, method = "rare"), xvar = "individuals")


# more sophisticaed multi-step ordination plotting
ord_obj <- metaMDS(otu_table)
trees_aug <- subset(trees, as.POSIXct(trees$Date_sampled) > as.POSIXct("2017-08-01"))


group_labels <- c(rep("Balboa", 5),
                  rep("Downtown", 5),
                  rep("Mt. Davidson", 5),
                  rep("Bay", 5),
                  rep("Freeway", 5),
                  rep("Ocean", 5))
pdf("figures/prelim_ordination_DBH.pdf")
plot(ord_obj,
     display = "sites",
     type = "n",
     main = "NMDS ordination of fungal community composition")

points(ord_obj,
       display = "sites",
       col = c(rep("blue", 5),
               rep("green", 5),
               rep("yellow", 5),
               rep("orange", 5),
               rep("red", 5),
               rep("purple", 5)),
       cex = trees_aug$DBH_cm/10,
       pch = 16)

legend("bottomleft",
       legend = levels(factor(group_labels)),
       pch = 16,
       cex = 1,
       pt.cex = 2,
       col = c("blue",
               "orange",
               "green",
               "red",
               "yellow",
               "purple"))

ordiellipse(ord_obj,
            groups =group_labels,
            label = FALSE,
            col = c("blue",
                    "orange",
                    "green",
                    "red",
                    "yellow",
                    "purple"),
            lwd = 3)
dev.off()
