---
title: Urban biogeography of fungal endophytes across San Francisco
preprint: false
author: 
  - name: Emma Gibson
    affiliation: 1
    corresponding: true
    email: emmagibson133@gmail.com
  - name: Naupaka Zimmerman
    affiliation: 2
affiliation:
  - code: 1
    address: (unsure)
  - code: 2
    address: (unsure)
abstract: >
 In natural and agricultural systems, the plant microbiome —the microbial organisms associated with plant tissues—has been shown to have important effects on host physiology and ecology, yet we know little about how these plant-microbe relationships play out in urban environments. Here we characterize the composition of fungal communities associated with leaves of one of the most common sidewalk trees in the city of San Francisco, California. We focus our efforts on endophytic fungi (asymptomatic microfungi that live inside healthy leaves), which have been shown in other systems to have large ecological effects on the health of their plant hosts. Specifically, we characterized the foliar fungal microbiome of *Metrosideros excelsa* trees growing in a variety of urban environmental conditions. We used high-throughput culturing, PCR, and Sanger sequencing of the ITS nrDNA region to quantify the composition and structure of fungal communities growing within healthy leaves of 30 *M. excelsa* trees from 6 distinct sites, which were selected to capture the range of environmental conditions found within city limits. Sequencing resulted in 921 high-quality ITS sequences. These sequences clustered into 88 Operational Taxonomic Units (97% VSEARCH OTUs). We found that these communities encompass relatively high alpha (within) and beta (between-site) diversity. Because the communities are all from the same host tree species, and located in relatively close geographical proximity to one another, these analyses suggest that urban environmental factors such as urban heat islands or differences in traffic density (and associated air quality) could potentially be influencing the composition of these fungal communities. These biogeographic patterns provide evidence that plant microbiomes in urban environments can be as dynamic and complex as their natural counterparts. As human populations continue to transition out of rural areas and into cities, understanding the factors that shape environmental microbial communities in urban ecosystems stands to become increasingly important.
bibliography: references.bib
output:
  rticles::peerj_article: default
  bookdown::pdf_book:
    base_format: rticles::peerj_article # for using bookdown features like \@ref()
---







# Introduction {-}

Although major cities and urban centers only cover a small portion the Earth's total geographic area, more than 50% of the human population lives in these urban centers, and the impact that these cities have on the environment can be seen worldwide [@schneider2009new]. As people continue to move to urban environments, understanding the ecology of cities and urban settings will become critical to human health and well being. Despite their comparatively small geographic size, the high density of human populations in these environments makes them distinct ecosystems with their own unique dynamics [@sukopp1998urban]. Urban environments represent the convergence of humans from around the world, any plant or animal species those humans might have brought with them, and infrastructures such as roads, sewers, and tall buildings. Despite their complexity that these ecosystems present, they are often overlooked by ecologists because more traditional ecology has focused on 'natural' systems. In urban systems, however, human influence is a primary ecological factor [@mcdonnell2011history]. In recent years, ecologists have begun studying the urban environment just as they would a natural environment, in order to understand the novel environmental conditions this setting presents to the organisms that live there [@wu2014urban]. 

In this study, we focus on the urban ecology of trees in San Francisco, California. Urban trees can play a major role in shaping the ecosystem of a city. Just as the trees in a forest have a considerable impact on its climate and ecology, trees in cities can have notable effects on a city's environment. For example, plant life in cities can impact temperature, air quality, and other aspects of human health [@Willis374]. The urban heat island effect, which occurs when 'islands' of heat form as heat gets trapped between tall buildings, is one of the most well-documented unique urban anthropogenic environmental conditions [@oke1973city]. Trees in urban environments have been shown to interact with these city-specific environmental factors [@salford40381]. For example, trees in cities have been shown to improve urban air quality by taking up significant amounts of carbon dioxide from city air [@NOWAK2014119]. As pollution generated in urban centers is one of the major contributing factors to worldwide pollution, trees in urban environments may have a role in managing the environmental impacts of urbanization [@alberti2003integrating].

Due to their importance, there is growing interest in understanding and maintaining sustainable urban ecologies. One potentially major factor influencing health of plants both in nature and cities is the plant microbiome. As the widespread availability of DNA sequencing has made it possible to characterize microbial communities more easily and comprehensively, the microbiome has become a major area of interest in numerous organisms [@kyrpides2016microbiome]. Just as the emerging field of human microbiome study has revealed that symbiotic, nonpathogenic microbes can have major impacts on human  health [@david2014diet], plant life is also host to numerous symbiotic microbes. Similar to the human microbiome, the plant microbiome contains great diversity and is comprised of multiple distinct communities in various tissue systems such as the roots (rhizosphere), leaf surface (phylosphere), and leaf interior (endosphere) [@turner2013plant]. All of these microbiomes can have an impact on their host's physiology. For instance, bacterial root microbes have been shown to play a role in the growth of various plant species[@gaiero2013inside]. They can also play a variety of roles in host physiology, depending on their location within the plant [@schlaeppi2015plant]. These communities can be quite dynamic, and vary with factors such as plant age [@cavaglieri2009rhizosphere]. while each of these sets of interactions is important, here we focus on the microbial ecology of fungal microorganisms living in the endosphere.

The endosphere is  is an ideal system for biogeographic studies, both because it is highly diverse and because it is a major interface between the host plant and its environment [@meyer2012microbiology]. 

Endophytic microbes are naturally found in the spacious interior of leaves, whether introduced by natural wounds or openings in the leaf surface, or through penetrating the plant sirface with hydrolytic enzymes [@hallmann1997bacterial] Although some of these microbes may be latent pathogens or decomposers waiting for the leaf to die, others are mutualists that may confer a benefit to their host [@carroll1988fungal]. In wild grasses, symbiotic fungi have been shown to protect their hosts by discouraging herbivory, and can even affect host reproductive viability in those same systems [@clay1988fungal]. In controlled settings, inoculation experiments have shown that specific species of endophytes can have an impact on their host’s overall health, including factors such as resistance and susceptibility to disease [@Busby2016]. In nature, the fungal microbial communities can have impacts on their host's physiology, such as limiting pathogen damage [@arnold2003fungal]. 

In the wild, endophytic communities display species diversity comparable to that of any macroscopic community, even among individual trees from the same species [@gazis2011]. However, what factors influence this diversity and to what extent is still poorly understood. The biodiversity of these communities can be quite high, especially in areas like tropical forests [@arnold2007diversity]. In such natural settings, plant-associated microbial community compositions can show clear biogeographic structure [@andrews2000ecology]. The urban setting, however, may be distinct, because factors such as rainfall and elevation will likely be less apparent over a smaller geographic area, but new factors such as proximity to roads and tall buildings may introduce effects of their own. Studies of suburban forests in Japan have indicated that an urban setting has a notable impact on endophytic diversity [@MATSUMURA2013191]. However, the full impact of urban environmental factors on endophytic communities has yet to be completely understood.

In this study, used culturing and barcode gene sequencing to identify the species makeup of endophytic communities in the New Zeland Christmas Tree,  *Metrosideros excelsa* (Myrtaceae), throughout San Francisco, CA to quantify the diversity and biogeographic patterns of foliar fungal communities in this urban environment. Based on studies in natural systems, we expected to find high community diversity both within and between sites, as well as a degree of biogeographic structure to these community compositions. We also expected that urban environmental factors may play a role in shaping the biogeography in these endophytic communities.

# Methods

## Host Selection

We chose to focus on *Metrosideros excelsa* individuals (Figure 1). *Metrosideris excelsa* was an ideal species to choose for this study because it is widely planted throughout San Francisco, which indicates that it likely has a major impact on the urban environment, and that we would be able to obtain samples from a large number of trees in a variety of locations throughout the city. Although *M. excelsa's* endophytic communities have been characterized in its native home of New Zeland,  there have been few studies about these communities outside of its native environment or in an urban setting [@mckenzie1999]. In a related Hawaiian species, *Metrosideros polymorpha*, the species makeup of fungal endophyte communities has been shown to vary greatly with environmental factors such as elevation and rainfall [@Zimmerman13022]. 

## Site Selection

We selected six sites across the city tocollect leaf samples from. When selecting sites, we took factors such as traffic levels, temperature, proximity to tall buildings, elevation, and proximity to the ocean into account. In selecting the sites, we wanted to capture the greatest range of potential urban climates as we could. We used the Urban Forest Map, which documents the location and species of every tree in San Francisco, to choose unique locations around the city with sufficient densities of Metrosideros excelsa individuals (Figure 1).


## Sample Collection

We collected small branches from 5 trees in each of these sites using a clipper pole, collected at least 3 sun-facing outer branches from each tree. We controlled for leaf age by picking leaves that appeared to be older than one year. Because *M. excelsa* is an evergreen tree, and the newer leaves are likely to contain fewer fungi, we only collected branches that contained dark green leaves that appeared to be at least one year old. We collected all samples on the same day, August 26, 2017, to ensure that daily weather patterns and seasonal effects would not have an impact on the microbial community composition. Once collected, leaves were stored in labeled plastic bags and stored at 4$^{\circ}$C until culturing. All leaves were processed within 48 hours of collection.

## Culturing

After we brought the branches back, we selected a subset of dark green asymptomatic leaves to culture. We surface-sterilized the leaves by first rinsing them with distilled water, then rinsing them in a petri dish with 95% ethanol for 10 seconds, 10% NaOCl for 2 minutes, then 70% ethanol for another 2 minutes, emptying the dish between rinses and leaving it closed until inside a sterile biosafety cabinet after the last rinse. Then we cut the leaves into small (2mm x 2mm) pieces and put them into 1.5 mL microcentrifuge slant tubes filled with 2% VWR-brand malt extract agar (MEA). We used MEA because it is considered the standard media for isolating the largest variety of fungal species. For each tree, we prepared 6 leaves and made 100 tubes, except for the trees from the downtown site. For these trees, we prepared 140 tubes per tree because they had low isolation frequencies in a preliminary sampling. All leaves were prepared this way within 48 hours of the initial leaf sampling, to prevent death of the leaf tissue from altering the fungal community composition.

After two weeks, we evaluated the tubes for fungal growth and subcultured the emergent fungi from tubes with growth onto 35mm 2% MEA in order to better evaluate their morphotypes and accumulate sufficient tissue for future barcode gene sequencing and voucher preparation. We re-evaluated and subcultured these tubes in the following months to capture any late-growing fungi. Each pure culture was vouchered in sterile dI water and stored in a living culture collection in the Zimmerman Lab at the University of San Francisco.

## Molecular Methods

We extracted DNA from fungal mycelium using the Sigma RED Extract ‘n Amp DNA extraction kit and following previously published protocols [@uren2012a]. First, we added fungal tissue to sterile tubes filled with 1 mm zirconium oxide beads, then added 100 microliters of Extract 'n' Amp DNA extraction solution. Next, we put the tubes in the bead-beater for one minute. The samples were then placed on a heat block at 95$^{\circ}$C for 10 minutes. After the heating step, we added a dilution buffer to each tube and stored them at 4$^{\circ}$C until PCR.

We performed PCR on the Internal Transcribed Spacer region, a commonly-accepted fungal barcode locus [@schoch2012nuclear], using the ITS1F forward primer (5'-CTT GGT CAT TTA GAG GAA GTA A-3') and ITS4 reverse primer (5'-TCC TCC GCT TAT TGA TAT GC-3'). For each PCR reaction, we used 1 $\mu$L of template DNA, 10 $\mu$L Extract ‘n Amp Taq polymerase, 6.4 $\mu$L PCR-grade water, 1 $\mu$L bovine serum albumin, 0.8 $\mu$L ITS1F forward primer, and 0.8 $\mu$L ITS4 reverse primer [@uren2012a]. For the PCR reaction, we used a BioRAD T100 thermal cycler with the following cycles: 95$^{\circ}$C for 3 minutes, 95$^{\circ}$C for 30 seconds, 54$^{\circ}$C for 30 seconds, 72$^{\circ}$C for 30 seconds, repeat steps 2-4 34 times and then, 72$^{\circ}$C for 10 minutes. To ensure that the fungal DNA successfully amplified, and that the master mix was not contaminated, we ran 5 $\mu$L of each sample and a negative PCR control on a 1% agarose gel with 1X Tris-acetate-EDTA (TEA) buffer and SYBR Safe. The gel was run at 120 volts for 20 minutes and visualized using UV transmission. Successful PCR samples with clean negative controls were kept at 4$^{\circ}$C until sequencing preparation.

To prepare successful samples for Sanger sequencing, they were first cleaned with 1 $\mu$L Thermo Fisher Shrimp Alkaline Phopsphatase Exonuclease (ExoSap) per sample. To clean the samples, we used the following cycle on the same BioRAD T100 thermal cycler: 37$^{\circ}$C for 15 minutes, 80$^{\circ}$C for 15 minutes, then infinite hold at 4$^{\circ}$C. After cleaning, samples were kept at 4$^{\circ}$C until they were ready to be sent for sequencing. Directly before being sent for sequencing, cleaned samples that showed bright bands on their gels were diluted with an additional 15 $\mu$L PCR water before sequencing, although a small number of samples that had faint bands on the gels were not diluted. Cleaned samples were sent to MCLabs (South San Francsisco, CA) for Sanger sequencing.

## Computational and Statistical Methods

We used Geneious 11.1 to manually clean and trim the Sanger sequencing data, and to identify and remove failed and low-quality sequences [@geneious]. Sanger sequence quality was determined using Geneious's chromatogram, and sequences that appeared to have multiple strong signals at a given position were discarded because they likely came from a mixed culture. Usable sequences were cleaned by trimming the ends with low-quality reads, clarifying any ambiguity codes, and resolving dye blobs.

 We used Mothur version 1.39.5 to determine Operational Taxonomic Units (OTUs), which are groups of sequences categorized together based on similarity [@schloss2009introducing]. Next, we used R to analyze the resulting OTU table. This included using the ‘vegan’ package to run and plot a Non-Metric Multidimensional Scaling (NMDS) ordination, a non-parametric technique used to visualize high-dimensional community data in only two dimensions. We used vegan [@vegan] to calculate species accumulation curves to determine species richness from the OTU data. We used the Tree-Based Alignment Selector (TBAS) toolkit to construct a phylogeny and assign taxonomies to the data [@tbas]. This toolkit matches unknown ITS sequences to the most similar ITS sequences in a large multi-gene phylogeny of confidently-assigned taxa.
 
Significant differences in isolation frequency and tree diameter were determined using a nonparametric Kruskal–Wallis one-way test of variance in R 3.4.4 [@r-citation].  All figures and the final manuscript were generated using an R Markdown script, which is available here: https://github.com/ZimmermanLab/SF-metrosideros-endophytes/blob/master/eg_thesis.Rmd

# Results

Overall, we found high diversity in these urban endophytic communities. While some communities showed a low number of fungal isolates, species richness analyses showed that in nearly all of the microbial communities analyzed, our sampling did not encompass the complete microbial diversity within these microbiomes. While the species diversity within some sites exceeds 20 distinct fungal OTUs, there appears to be greater species diversity in these endophytic communities than this study was able to document. Furthermore, the taxonomic variation between different sites is also considerable, as there is no taxon that dominates in all sites, although there are several taxa that show a degree of prominence in all sites.

## Isolation Frequency

The isolation frequency, or the percentage of leaf pieces that yielded fungal isolates, varied significantly between sites (Kruskal Wallis p < 0.01, Figure 2 A.). In most sites, the isolation frequency also varies between trees, especially in the Bay site. Trees within the Bay site also show the greatest variation in diameter at breast height (DBH) (Figure 2 B.). The only site that does not show as consistent variation in isolation frequency is the Downtown site, which is also the site with the smallest isolation frequencies.

## Diversity Patterns

There were 88 total OTUs found among the 30 different trees. Both isolation frequency and number of fungal species found varied notably between trees. Species accumulation curves showed that the total amount of fungal diversity has not been completely sampled in any of the sites (Figure 3).

The most abundant fungal class among all communities is Dothideomycetes, followed by Sordariomycetes, which each had over 300 sequence (Table 1). Dothidewas predominant in most sites except for the Downtown and Bay sites. In both of these sites, Sordariomycetes is the most common class instead. There are several classes that are either absent or present in small numbers in most sites, but more abundant in one or several sites. For example, Eurotiomycetes are more common in the Downtown and Freeway sites, and Leotiomycetes are only abundant in the Mt. Davidson site.

## Biogeographic Patterns

The similarities between  microbial communities of these trees vary (Figure 5). Some sites show very little compositional similarity, while others cluster more tightly, indicating a greater degree of within-site beta diversity. However, sites that were closer together geographically also tended to have greater microbial community similarities.

# Discussion

In this study, we sought to characterize the foliar microbiome of *Metrosideros excelsa* trees across the city of San Francisco. We found that he microbial composition of these urban trees' leaves varies in many aspects, from number of fungal isolates to the identities of said isolates. This variation could be explained by numerous environmental factors, as well as host physiological factors, such as the age and size of the tree. Each aspect of these complex microbiomes is likely influenced by several of these factors at once. 

##  Isolation Frequency and Tree size

Both isolation frequency and DBH varied greatly from one site to the other, and some sites show considerable within-site differences in these factors as well. The trees in the Bay show the greatest range in both isolation frequency and DBH (Figure 2 A and B), indicating that the size of a tree may have a correlation with the number of fungal endophytes found within its leaves. The Mt. Davidson trees have a larger median and range of DBH than the ocean or freeway trees (Figure 2 B.), and also have a higher median isolation frequency, which could indicate that trees with a larger DBH may also have a higher number of fungal endophytes.

Just as it shows the greatest range of isolation frequencies and tree sites, the Bay site also has some of the least similarity between its fungal communities on the NMDS ordination, and the two trees with vastly different communities are also the smallest (Figure 5). In this instance, it appears that the size of the trees has the largest impact on the endophytic communities. Furthermore, the trees in the Mt. Davidson site, which have some of the most similar communities (Figure 5), also have fairly large trees with similar DBH. The fact that these trees have similar sizes in addition to similar community composition indicates that a tree's size may have an impact on its endophytic communities.

Although there appears to be a general pattern with larger trees hosting a greater number of fungal endophytes, DBH cannot explain all of the variation in isolation frequencies, as demonstrated by the Downtown and Balboa sites. Although the trees from the downtown site have a higher median DBH (Figure 2 B.), the trees from the Balboa site have considerably more endophytes (Figure 2 A.), which suggests that larger trees do not necessarily have a higher number of fungal endophytes.

## Diversity Patterns

Endophytic microbiomes in tree leaves are known to be highly diverse in natural systems, and that also appears to be the case in these urban trees. he species accumulation curves indicate that even in the most well-represented sites, these are still many potentially undiscovered OTUs within these endophytic communities (Figure3). Additionally, there is a considerable amount of taxonomic variation between certain sites, in addition to the generally high diversity of each site (Figure 4). In such cases, it is likely that environmental factors play a role in shaping the endophytic communities of these trees. While the impact of environmental factors may be less evident when considering the number of fungal endophytes in a tree's microbiome, it becomes more apparent when looking at the identities of these endophytes. The composition of these communities can vary greatly among trees with similar isolation frequencies, as demonstrated by the taxonomic composition of the Mt. Davidson and Bay sites (Figure 4). In general, there was higher compostitional similarity between trees from the same location than between trees of a similar size (Figure 5).

## Biogeographic Patterns

There appears to be a degree of biogeographic structure to the endophytic communities within these urban trees. Communities of trees from the same site generally cluster closer together than trees from different sites, although some sites have much greater within-site diversity than others (Figure 5). It may be more likely that some of the sites that show great within-site diversity simply appear that way due to undersampling. Although the Balboa site appears to have a high isolation frequency (Figure 2 A), many of the slant tubes that showed fungal growth failed to grow into a larger culture, leading to a low number of usable sequences (Figure 3). This low number of sequences per tree may indicate that the divergence in community composition that appears to be present might be due to the low sample size, rather than actual difference between the microbial communities between the Balboa trees (Figure 5).

However, even sites with low within-site diversity appear to be more similar to other trees from geographically close sites. For example, the Downtown trees do not cluster with the Mt. Davidson, Balboa, or Ocean trees in the ordination, indicating that they have fairly different fungal communities (Figure 5). One notable exception to this pastern is the Downtown and Freeway sites, which cluster fairly close together (Figure 5) despite being distant geographically (Figure 1). In this case, it is likely that there are environmental factors that cause the communities to be more compositionally similar. One of the most likely environmental similarities between these two sites is that they are both exposed to high traffic levels, with one site located in a bustling downtown and the other located near two large freeways. It is possible that carbon dioxide emissions, particulates, or both of these pollutants could be having an effect on both these trees and their microbiomes. Endophytic bacteria has been shown to have a phytoremediating effect [@afzal2014endophytic], so it is possible that endophytic fungi may be playing a similar role in helping these plants adapt to traffic-heavy conditions.

## Community composition compared to related trees in other locations

In widely-distributed plant species, fungal endophyte composition can differ quite considerably in a species from its native home to the places it has been introduced [@taylor_hyde_jones_1999]. *M. excelsa* is native to New Zeland, but it and its close relatives in the *Myrtaceae* family are widespread across the world. Across all locations, the most abundant classes found within these *M. excelsa* fungal communities were Dothideomycetes and Sordariomycetes by a notable margin (Table 1). Interestingly, at broad taxonomic levels such as Class, the endophytes found in this study appear to be similar to those found in other Myrtaceae trees elsewhere. For instance, a study of *Myrtaceae* trees in South America, the first and second most common fungal isolates were also identified as Dothideomycetes followed by Sordariomycetes [@vaz2014fungal]. Dothideomycetes and Sordariomycetes are also the first and second most abundant classes in the endophytic communities of *M. excelsa's* close relative in Hawaii, *Metrosideros polymorpha*, as well [@Zimmerman13022]. This could indicate that these fungal classes are well-adapted to living as endophytes within these trees, but it is also possible that these communities are actually quite different when considered at a finer taxonomic resolution. 

## Comparison of trees in San Francisco and New Zealand

In order to compare the foliar microbial populations found in M. excelsa throughout San Francisco to its microbial populations in its native land of New Zealand, we both used genbank and performed a literature search. First, we searched Google Scholar for papers mentioning M. excelsa fungal endophytes and then, more generally, any foliar fungus inhabiting M. excelsa leaves. After this search, we looked through the papers cited by those we originally found in order to find additional recorded fungal isolates.
Then, we searched GenBank for fungal ITS sequences that had M. excelsa listed as their host organism. We performed this search using the parameters host="Metrosideros excelsa", organism=fungi, in order to limit our results to fungal sequences. This search yielded several new sequences that weren't included in the previous search because they were unpublished. Using both of these methods, we were able to find about 30 taxa to include as a point of comparison, although many of these were pathogenic instead of endophytic.

When comparing *M. excelsa's* endophytic populations found in the literature to those that we collected, we found that the taxa between the regions were somewhat similar on an order level, and even moreso on a class level. Only one of the orders that was extremely common in New Zealand (Mycospharales) was absent in San Francisco, and only two of the most common orders in San Francisco (Capnodiales and Pezizales) were absent in New Zealand.  However, most of the families that are found in New Zealand are absent in San Francisco, and vice versa. We only found four families in common: Mycosphaerellaceae, Glomerellaceae, Nectriaceae, and Helotiaceae. Of these, Mycosphaerellaceae is the only family that is present in New Zealand very prevalent (over 50 isolates) in San Francisco. The other families that they had in common were only present in very small numbers in San Francisco, and we were unable to find documentation of three most prevalent families in San Francisco (Xylariaceae, Botryosphaeriaceae, and Cladosporiaceae) being isolated from leaves in New Zealand. Although this could be due to the small sample size, it suggests that *M. excalsa's* endophytic populations may be influenced by their environment, rather than being carried over from their native home. However, further research into both the endophytic populations of other trees in San Francisco and M. excelsa in its native range would be required to draw further conclusions.
Additionally,  it is important to note the difference in methods between how we collected our samples and how others studying *M. excelsa* in New Zealand collected theirs. Whereas we took care to only collect samples from unfallen, asymptomatic leaves, most of the papers referenced in this comparison use either leaf litter, dead leaves, or obviously symptomatic leaves. Therefore, it is reasonable to infer that the data we are comparing our results to is biased towards pathogenic and decomposing fungi, and underrepresents the non-harmful endophytic populations in M. excelsa's native range. Additionally, the number of fungal isolates we were able to find using literature and genbank searches was much lower than the number of samples we collected ourselves, making quantitative comparison unfeasible. However, we think that such comparisons are still worthwhile as a preliminary look into the extent that *M. excelsa* in San Francisco may maintain its native endophytic populations.

## Conclusions

These findings indicate that the endophytic microbiomes of urban trees are complex and diverse, and may show a degree of biogeographic structure that reflects their natural counterparts. Additionally, it is likely that urban environmental factors play a considerable role in shaping the endophytic communities of these trees. This study has demonstrated that the urban endophytic microbiomeis highly diverse and may be structured by unique urban environmental factors. Nearly all of the species accumulation curves indicate that the full diversity of these endophytic communities has yet to be sampled (Figure 3). Even in the small geographic area of San Francisco, we found notable trends in microbiome composition that appear to vary with uniquely urban environmental factors, such as traffic. A combination of environmental factors and host physiology therefore appear to be the driving force behind the diversity of these microbiomes. While it is difficult to determine, given the data we have, the exact mechanisms that influence these communities, the amount of species diversity and biogeographic structure indicate that the foliar microbiomes of urban trees may be just as complex and dynamic as those of trees in nature, and warrant further study.

# Tables

**Table 1.** Abundances of *Ascomycota* classes across all trees and sites.


|Fungal class    | Number of sequences|
|:---------------|-------------------:|
|Dothideomycetes |                 450|
|Sordariomycetes |                 341|
|Eurotiomycetes  |                  57|
|Pezizomycetes   |                  52|
|Leotiomycetes   |                  19|

##### Page Break

# Figures

![](gibson2021_files/figure-latex/map-1.pdf)<!-- --> 

**Figure 1.** A map of the locations sampled across the city of San Francisco, California, USA. Five trees from each site were sampled. Sites were selected to span the range of environmental conditions across the city.

![](gibson2021_files/figure-latex/isolation-1.pdf)<!-- --> 

![](gibson2021_files/figure-latex/dbh-1.pdf)<!-- --> 

**Figure 2.** Isolation frequencies (A) and tree diameters (B) at each site. Isolation frequency (A) is a measure of how many slant tubes showed signs of fungal growth, out of how many total slant tubes were made. 100 slant tubes were made for each tree except for the trees in the downtown site, which had 140 slant tubes per tree because they had low isolation frequencies during the initial sampling.


![](gibson2021_files/figure-latex/rarefaction-1.pdf)<!-- --> 

**Figure 3.** Species accumulation curve showing species richness in each site. Each line represents the combined species richness of all trees in one site. 


![](gibson2021_files/figure-latex/bar-graph-1.pdf)<!-- --> 

**Figure 4.** Normalized relative abundances of *Ascomycota* taxa in each site.




![](gibson2021_files/figure-latex/ordination-1.pdf)<!-- --> 

**Figure 5.** NMDS ordination of community compositions. Each point represents the endophytic community of one tree, and the size of the point corresponds to that tree's DBH, while the color of said point corresponds to the site that tree is from. Points that are closer together indicate that the trees they represent have similar community compositions. The ellipses show the standard error around the centroid of all points within a site, and are also color-coded according to which site they represent.

# References
