library("dplyr")
library("tidyr")
library("vegan")

otus <- read.table("seq_with_OTU_ID.txt")
groups <- read.table("groupfile.tsv")
trees <- read.csv("2017-06-09_M_excel_tree_metadata - Sheet1.csv",
                  stringsAsFactors = FALSE)

otu_table <- otus %>% 
  left_join(groups, by = c("V1" = "V1")) %>%
  group_by(V2.x, V2.y) %>%
  summarize(count = n()) %>%
  spread(V2.x, count, fill = 0)

otu_table <- as.data.frame(na.omit(otu_table))

row.names(otu_table) <- otu_table[, 1]
otu_table <- otu_table[, -1]

otu_table <- otu_table[1:12,]

plot(metaMDS(otu_table), type = "t", display = "sites", cex = 1.5)

row.names(otu_table) <- c(paste("Balboa - Tree", 1:4),
                         paste("Downtown - Tree", 1:4),
                         paste("Mt. Davidson - Tree", 1:4),
                         "USF")

rarecurve(otu_table, main = "Species accumulation curves for endophytic fungi")
plot(colSums(otu_table))
plot(specaccum(otu_table, method = "rare"), xvar = "individuals")

ord_obj <- metaMDS(otu_table)
plot(ord_obj, 
     type = "points", 
     display = "sites", 
     cex = 1.5,
     main = "NMDS ordination of fungal community composition")
group_labels <- c(rep("Balboa", 4), rep("Downtown", 4), rep("Mt. Davidson", 4), "USF")
ordispider(ord_obj, 
           groups = group_labels, 
           label = TRUE,
           cex = 1.2)
