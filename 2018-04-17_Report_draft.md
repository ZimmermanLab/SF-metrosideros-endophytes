Urban biogeography of fungal endophytes across San Francisco
================
Emma Gibson and Naupaka Zimmerman
4/17/2018

``` r
# load libraries
library("dplyr")
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library("tidyr")
library("vegan")
```

    ## Loading required package: permute

    ## Loading required package: lattice

    ## This is vegan 2.4-6

``` r
library("ggplot2")
```

``` r
# load files
otus <- read.table("seq_with_OTU_ID.txt")
groups <- read.table("groupfile.tsv")
trees <- read.csv("metadata/M_excel_tree_metadata_with_isolationfreq.csv",
                  stringsAsFactors = FALSE)
TBAS <- read.csv("metadata/TBAS_taxonomies.csv")
culturing <- read.csv("metadata/culturing_worksheet.csv")
extractions <- read.csv("metadata/Extraction_worksheet.csv")

# count by groups instead of trees
otu_table <- otus %>%
  left_join(groups, by = c("V1" = "V1")) %>%
  group_by(V2.x, V2.y) %>%
  summarize(count = n()) %>%
  spread(V2.x, count, fill = 0)
```

    ## Warning: Column `V1` joining factors with different levels, coercing to
    ## character vector

``` r
# get rid of rows with NA
otu_table <- as.data.frame(na.omit(otu_table))

# fix row name problems for vegan
row.names(otu_table) <- otu_table[, 1]
otu_table <- otu_table[, -1]

# drop out USF test sample
otu_table <- otu_table[1:30,]
```

Abstract
========

In natural and agricultural systems, the plant microbiome —the microbial organisms associated with plant tissues—has been shown to have important effects on host physiology and ecology, yet we know little about how these plant-microbe relationships play out in urban environments. Here we characterize the composition of fungal communities associated with leaves of one of the most common sidewalk trees in the city of San Francisco, California. We focus our efforts on endophytic fungi (asymptomatic microfungi that live inside healthy leaves), which have been shown in other systems to have large ecological effects on the health of their plant hosts. Specifically, we characterized the foliar fungal microbiome of Metrosideros excelsa trees growing in a variety of urban environmental conditions. We used high-throughput culturing, PCR, and Sanger sequencing of the ITS nrDNA region to quantify the composition and structure of fungal communities growing within healthy leaves of 30 M. excelsa trees from 6 distinct sites, which were selected to capture the range of environmental conditions found within city limits. Sequencing resulted in 1044 high-quality ITS sequences. These sequences clustered into 97 Operational Taxonomic Units (97% VSEARCH OTUs). We found that these communities encompass relatively high alpha (within) and beta (between-site) diversity. Multivariate statistical analyses (NMDS, PERMANOVA) showed that fungal community composition was significantly different between sites (PERMANOVA p = 0.001). Since the communities are all from the same host tree species, and located in relatively close geographical proximity to one another, these analyses suggest that urban environmental factors such as urban heat islands or differences in traffic density (and associated air quality) could potentially be influencing the composition of these fungal communities. We are performing additional analyses to quantify how urban abiotic and anthropogenic factors may shape the composition of these trees' endophytic microbiomes. These biogeographic patterns provide evidence that plant microbiomes in urban environments can be as dynamic and complex as their natural counterparts. As human populations continue to transition out of rural areas and into cities, understanding the factors that shape environmental microbial communities in urban ecosystems stands to become increasingly important.

Introduction
============

As people continue to live in increasingly urban environments, understanding the ecology of cities and urban settings will become critical to human health. Just as rural environments contain complex and dynamic ecosystems, the human and non-human aspects of large city habitats interact to creats a unique urban ecosystem. In recent years, ecologists have begun studying the urban environment just as they would a natural environment, in order to understand the novel environmental conditions this setting presents to the organisms that live there. For example, recent studies have shown that plant life in large cities can impact temperature, air quality, and other aspects of human health (Willis and Petrokofsky 2017). A study spanning the United States showed that plant life can improve a city's air quality by taking up significant amounts of carbon dioxide from urban air (Nowak et al. 2014). Another study in China indicated that healthy plant life can reduce the urban heat island effect, which is caused when heat becomes trapped between tall buildings (Kong et al. 2014). Therefore, understanding the impact of urban environments on plant health could help to allow those plants to thrive, benefitting the human inhabitants of the city as well as the environment as a whole.

One potentially major factor influencing plant health that has yet to be studied in an urban environment in great detail is the endophytic microbiome. Endophytes are microbial organisms, generally bacteria and fungi, that live symbiotically inside the leaves of plants. Although some of these fungal microbes may be latent pathogens or decomposers waiting for the leaf to die, others are mutualists that may confer a benefit to their host. For instance, inoculation experiments have shown that specific species of endophytes can have an impact on their host’s overall health, including factors such as resistance and susceptibility to disease (Busby, Ridout, and Newcombe 2016). In the wild, endophytic communities display species diversity comparable to that of any macroscopic community, even among individual trees from the same species (GAZIS, REHNER, and CHAVERRI, n.d.). However, what factors influence this diversity and to what extent is still poorly understood. The urban setting is unique because factors such as rainfall and elevation will be less apparent in a smaller geographic area, but new factors such as proximity to roads and tall buildings may introduce effects of their own. Studies of suburban forests in Japan have indicated that an urban setting has a notable impact on endophytic diversity (<span class="citeproc-not-found" data-reference-id="MATSUMURA201319">**???**</span>). However, the full impact of urban environmental factors on endophytic communities has yet to be completely understood.

In this study, used culturing and barcode gene sequencing to identify the species makeup of endophytic communities in *Metrosideros excelsa* throughout San Francisco to relate environmental factors with fungal community composition. *M. excelsa* was an ideal species to choose for this study because it is both widely planted throughout San Francsico, and its endophytic communities have been documented in previous studies. In a related Hawaiian species, *Metrosideros polymorpha*, the species makeup of fungal endophyte communities has been shown to vary greatly with environmental factors such as elevation and rainfall (Zimmerman and Vitousek 2012). Although *M. excelsa's* endophytic communities have ben characterized in its native home of New Zealand, there have been few studies about these communities outside of its native environment or in an urban setting (McKenzie, Buchanan, and Johnston 1999).

Methods
=======

Culturing Methods
-----------------

``` r
#figure out how to embed images
```

### Figure 1. Map ofthe locations sampled

We used the Urban Forest Map, which documents the location and species of every tree in San Francisco, to choose 6 unique locations around the city with enough *Metrosideros excelsa* individuals (Figure 1). We collected small branches from 5 trees in each of these sites using a clipper pole, collected at least 3 sun-facing outer branches from each tree. Because *M. excelsa* is an evergreen tree, and the newer leaves contain less fungi, we only collected branches that contained dark green leaves that appeared to be at least one year old. We collected all leaf samples on the same day (August 26, 2017) to ensure that weather and season would not have an impact on the microbial community composition.

After we brought the branches back, we selected a subset of dark green asymptomatic leaves to culture fungi from. These leaves were surface-sterilize with bleach and ethanol to kill off any surface microbes. Then we cut the leaves into small pieces and put them into slant tubes filled with malt extract agar (MEA). We used MEA because it is considered the standard media for isolating the largest variety of fungal species. For each tree, we prepared 6 leaves and made 100 tubes, except for the trees from the downtown site. For these trees, we prepared 150 tubes per tree because they had low isolation frequencies in our preliminary sampling. All leaves were prepared this way within 48 hours of the initial leaf sampling, to prevent death of the leaf tissue from altering the fungal community composition.

After two weeks, we evaluated them for fungal growth and subcultured the fungi from tubes with growth onto 35mm MEA in order to better evaluate their morphotypes and accumulate sufficient tissue for future barcode gene sequencing and voucher preparation. We re-evaluated and subcultured these tubes another week later to find any late-growing fungi.

Molecular Methods
-----------------

We extracted DNA from the fungal cells using a bead-beater and the Extract ‘n Amp DNA extraction kit. First, we added fungal tissue to sterile tubes filled with small beads, then added extraction solution. Next, we put the tubes in the bead-beater for one minute, which vigorously shook the tubes so that the beads inside could physically grind up the fungal tissue. This step is necessary in fungal DNA extractions because fungi have cell walls, which are difficult for extraction solution to break up without this physical grinding step. Next, the samples were placed on heat blocks at 95°C for 10 minutes. After the heating step, we added a dilution buffer to each tube and stored them in a refrigerator to prevent degradation until PCR.

We performed PCR on the ITS region, a commonly-accepted fungal barcode gene, using the ITS1F forward primer and ITS4 reverse primer. We used Extract ‘n Amp Taq polymerase, and a 35-repeat cycle. PCR samples were cleaned and prepared for sequencing using Shrimp Alkaline Phopsphatase Exonuclease (ExoSap), then sent to MCLabs for Sanger sequencing.

Computational Methods
---------------------

We analyzed the data using three tools: Geneious, Mothur, and the R programming language. We used Geneious to manually clean and trim the Sanger sequencing data, and to identify and remove failed and low-quality sequences (Kearse et al. 2012). We used Mothur to determine Operational Taxonomic Units (OTUs), which are groups of sequences categorized together based on similarity. Next, we used R to analyze the resulting OTU table. This included using the ‘vegan’ package to run and plot a Non-Metric Multidimensional Scaling (NMDS) ordination, a non-parametric technique used to visualize high-dimensional community data in only two dimensions. Lastly, we used vegan (???) to calculate PERMANOVA values in order to prove that observed patterns were significant.

Results
=======

Isolation Frequency
-------------------

Species richness
----------------

``` r
#set colors
rare_color = c(rep("#ff5e62", 5),
               rep("#f0a200", 5),
               rep("#007f36", 5),
               rep("#8781e6", 5),
               rep("#00005a", 5),
               rep("#81005e", 5))

#rename sites to be more readable
group_labels <- c(rep("Balboa", 5),
                  rep("Downtown", 5),
                  rep("Mt. Davidson", 5),
                  rep("Bay", 5),
                  rep("Freeway", 5),
                  rep("Ocean", 5))

#draw the species richness curves
rarecurve(otu_table,
          main = "Species accumulation curves for endophytic fungi",
          col = rare_color,
          label = FALSE,
          lwd = 2,
          xlab = "Number of fungal isolates",
          ylab = "Number of fungal species (97% ITS OTUs)")

#add a legend for greater readability
legend("bottomright",
       legend = levels(factor(group_labels)),
       pch = 16,
       col = c(rep("#ff5e62"),
               rep("#8781e6"),
               rep("#f0a200"),
               rep("#00005a"),
               rep("#007f36"),
               rep("#81005e")))
```

![](2018-04-17_Report_draft_files/figure-markdown_github/rarefaction-1.png) \#\#\#Figure 3. Rarefaction curve showing species richness in all trees & sites

The species richness curve graphs the number of fungal species (OTUs) found versus the totla number of fungal isolates for each tree's microbiome. Each line represents one tree's community, and the color of the line represents which site each tree was located in. A sharply angled line indicates that the full species diversity has not been samples, and a line that plateaus indicated that most of the species available in that community have been sampled. There were 97 total OTUs found among the 30 different trees. Both isolation frequency and number of fungal species found varies notably between trees.

``` r
extraction_with_tree <- read.table("groupfile.tsv",
                                   sep = "\t",
                                   col.names = c("Extraction_ID", "Tree_ID")) %>%
  mutate(site_ID = substr(Tree_ID, 1, 2))

TBAS_names_fixed <- TBAS %>%
  mutate(Extraction_ID = substr(Query_sequence, 1, 8))

TBAS_with_site <- TBAS_names_fixed %>%
  left_join(extraction_with_tree, by = "Extraction_ID") %>%
  na.omit()
```

    ## Warning: Column `Extraction_ID` joining character vector and factor,
    ## coercing into character vector

### Figure 4. Prominent Taxa in each site

The most prominent

NMDS Ordination
---------------

``` r
ord_obj <- metaMDS(otu_table)
```

    ## Wisconsin double standardization
    ## Run 0 stress 0.2365893 
    ## Run 1 stress 0.2366079 
    ## ... Procrustes: rmse 0.04123009  max resid 0.105673 
    ## Run 2 stress 0.2575533 
    ## Run 3 stress 0.2365904 
    ## ... Procrustes: rmse 0.001521073  max resid 0.004787468 
    ## ... Similar to previous best
    ## Run 4 stress 0.2489858 
    ## Run 5 stress 0.240694 
    ## Run 6 stress 0.245747 
    ## Run 7 stress 0.236612 
    ## ... Procrustes: rmse 0.04121139  max resid 0.1041449 
    ## Run 8 stress 0.2367419 
    ## ... Procrustes: rmse 0.03782502  max resid 0.101851 
    ## Run 9 stress 0.2466173 
    ## Run 10 stress 0.2368153 
    ## ... Procrustes: rmse 0.01772226  max resid 0.07546903 
    ## Run 11 stress 0.2523475 
    ## Run 12 stress 0.2387748 
    ## Run 13 stress 0.2465185 
    ## Run 14 stress 0.2369467 
    ## ... Procrustes: rmse 0.03673694  max resid 0.1016372 
    ## Run 15 stress 0.24167 
    ## Run 16 stress 0.242381 
    ## Run 17 stress 0.2527246 
    ## Run 18 stress 0.2398427 
    ## Run 19 stress 0.2387746 
    ## Run 20 stress 0.2537874 
    ## *** Solution reached

``` r
# fix row names to be more readable
row.names(otu_table) <- c(paste("Balboa - Tree", 1:5),
                         paste("Downtown - Tree", 1:5),
                         paste("Mt. Davidson - Tree", 1:5),
                         paste("Bay - Tree", 1:5),
                         paste("Freeway - Tree", 1:5),
                         paste("Ocean - Tree", 1:5))

trees_aug <- subset(trees, as.POSIXct(trees$Date_sampled) > as.POSIXct("2017-08-01"))

plot(ord_obj,
     display = "sites",
     type = "n",
     main = "NMDS ordination of fungal community composition",
     cex.main = 1.6,
     xlab = "",
     ylab = "",
     tck = 0,
     labels = FALSE)
```

    ## Warning in plot.window(...): "labels" is not a graphical parameter

    ## Warning in plot.xy(xy, type, ...): "labels" is not a graphical parameter

    ## Warning in box(...): "labels" is not a graphical parameter

    ## Warning in title(...): "labels" is not a graphical parameter

``` r
points(ord_obj,
       display = "sites",
       col = c(rep("#ff5e62", 5),
               rep("#f0a200", 5),
               rep("#007f36", 5),
               rep("#8781e6", 5),
               rep("#00005a", 5),
               rep("#81005e", 5)),
       cex = trees_aug$DBH_cm/10,
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
            groups =group_labels,
            label = FALSE,
            col = c(rep("#ff5e62"),
                    rep("#8781e6"),
                    rep("#f0a200"),
                    rep("#00005a"),
                    rep("#007f36"),
                    rep("#81005e")),
            lwd = 7)
```

![](2018-04-17_Report_draft_files/figure-markdown_github/ordination-1.png)

### Figure 5. NMDS ordination of community composition

A non-metric multidimensional scaling (NMDS) ordination graphs the microbial communities of each tree by compositional similarity using the DNA sequences from each tree. Each point represents the endophytic community of one tree, and the size of the point corresponds to that tree's diameter at breast height (DBH), while the color of said point corresponds to the site that tree is from. The ellipses show the standard error around the centroid of all points within a site, and are also color-coded according to which site they represent.

Discussion
==========

The major, overarching takeaway from this study is that the urban endophytic microbiome contains a great amount of diversity and should not be overlooked. Even in the small geographic area of San Francisco, we found notable trends in microbiome composition that appear to vary with uniquely urban environmental factors, such as traffic.

The NMDS ordination indicates that urban environmental factors play a considerable role in shaping the endophytic communities of these trees. Some of the NMDS groupings can be explained by geographic proximity, like the Ocean and Balboa sites. However, the proximity of the Downtown and Freeway sites indicate that there may be common environmental factors impacting community composition, such as traffic and pollution.

The isolation frequency varied greatly from one site to the other, and while some sites showed similar isolation frequencies across all trees, others had a wide variety of

The Bay site shows the greatest diversity in fungal communities on the NMDS ordination, as well as a large difference in isolation frequency and DBH. Although this could be due to the climate of the bay, we believe that it is more likely due to the age of the trees. The two trees with vastly different communities are also the smalles, and therefore likely youngest, trees (Figure 5).Younger trees have been exposed to less endophytes, This conclusion is further supported by the fact that the Mt. Davidson site, which has the most tightly-clustered communities (Figure 5), also has fairly large trees with similar DBH.

Sources Cited
=============

Busby, Posy E., Mary Ridout, and George Newcombe. 2016. “Fungal Endophytes: Modifiers of Plant Disease.” *Plant Molecular Biology* 90 (6): 645–55. doi:[10.1007/s11103-015-0412-0](https://doi.org/10.1007/s11103-015-0412-0).

GAZIS, ROMINA, STEPHEN REHNER, and PRISCILA CHAVERRI. n.d. “Species Delimitation in Fungal Endophyte Diversity Studies and Its Implications in Ecological and Biogeographic Inferences.” *Molecular Ecology* 20 (14): 3001–13. doi:[10.1111/j.1365-294X.2011.05110.x](https://doi.org/10.1111/j.1365-294X.2011.05110.x).

Kearse, Matthew, Richard Moir, Amy Wilson, Steven Stones-Havas, Matthew Cheung, Shane Sturrock, Simon Buxton, et al. 2012. “Geneious Basic: An Integrated and Extendable Desktop Software Platform for the Organization and Analysis of Sequence Data.” *Bioinformatics* 28 (12): 1647–9. doi:[10.1093/bioinformatics/bts199](https://doi.org/10.1093/bioinformatics/bts199).

Kong, F, H Yin, P James, LR Hutyra, and HS He. 2014. “Effects of Spatial Pattern of Greenspace on Urban Cooling in a Large Metropolitan Area of Eastern China.” *Landscape and Urban Planning* 128. Elsevier: 35–47. doi:[10.1016/j.landurbplan.2014.04.018](https://doi.org/10.1016/j.landurbplan.2014.04.018).

McKenzie, E. H. C., P. K. Buchanan, and P. R. Johnston. 1999. “Fungi on Pohutukawa and Other Metrosideros Species in New Zealand.” *New Zealand Journal of Botany* 37 (2). Taylor & Francis: 335–54. doi:[10.1080/0028825X.1999.9512637](https://doi.org/10.1080/0028825X.1999.9512637).

Nowak, David J., Satoshi Hirabayashi, Allison Bodine, and Eric Greenfield. 2014. “Tree and Forest Effects on Air Quality and Human Health in the United States.” *Environmental Pollution* 193: 119–29. doi:[https://doi.org/10.1016/j.envpol.2014.05.028](https://doi.org/https://doi.org/10.1016/j.envpol.2014.05.028).

Willis, Katherine J., and Gillian Petrokofsky. 2017. “The Natural Capital of City Trees.” *Science* 356 (6336). American Association for the Advancement of Science: 374–76. doi:[10.1126/science.aam9724](https://doi.org/10.1126/science.aam9724).

Zimmerman, Naupaka B., and Peter M. Vitousek. 2012. “Fungal Endophyte Communities Reflect Environmental Structuring Across a Hawaiian Landscape.” *Proceedings of the National Academy of Sciences* 109 (32). National Academy of Sciences: 13022–7. doi:[10.1073/pnas.1209872109](https://doi.org/10.1073/pnas.1209872109).
