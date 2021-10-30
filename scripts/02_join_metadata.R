# Draft of R script to create metadata file for analysis from subculturing
# worksheets and write out for later use by the next script

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017
# Updated October 29, 2021

# load packages
library("dplyr")

# set debug -- if TRUE, will output more information for checking assumptions
debug <- FALSE

# load data
culturing <- read.csv("data/metadata/culturing_worksheet.csv",
                      stringsAsFactors = FALSE)
extractions <- read.csv("data/metadata/Extraction_worksheet.csv",
                        stringsAsFactors = FALSE)
trees <- read.csv("data/metadata/M_excel_tree_metadata_with_isolationfreq.csv",
                  stringsAsFactors = FALSE)


# goal is to find the highest level parent of a given culture
# we accomplish this for an arbitraty number of parents using a
# recursive function
find_top_level_parent <- function(culture_id) {
  if (culture_id %in% culturing$Label_ID) {
    find_top_level_parent(
      culturing[culturing$Label_ID == culture_id, "From_Label_ID"])
  }
  else {
    return(culture_id)
  }
}

# test to make sure the function works
stopifnot(find_top_level_parent("ZUSF02440") == "S5T3")

# another check
if (debug) find_top_level_parent("ZUSF00641")

# populate parent column with NAs to start
extractions$original_sample <- NA

# resursively lookup top-level parent of each culture and add to parent column
for (i in seq_len(extractions)) {
  # because the data are messy we need to first check only for those culture
  # IDs that match the proper naming convention
  if (grepl(pattern = "^ZUSF[0-9]{5}", x = extractions$Culture_Label_ID[i]) &

      # and then we also need to check that they don't occur multiple times
      # in the culturing sheet (due to typos)
      (!extractions$Culture_Label_ID[i] %in%
       culturing$Label_ID[duplicated(culturing$Label_ID)])) {

    # if both of those conditions are met, then find the parent of the culture
    # using the recursive lookup function defined above and assign into the
    # column 'original_sample' in the extractions data frame
    extractions$original_sample[i] <-
      find_top_level_parent(
        extractions$Culture_Label_ID[i])
  }
}

# Manually set name for USF testing sample
extractions$original_sample[
  extractions$original_sample == "Test Sample"] <- "Test_Sample"

# fix zero padding errors in extraction IDs
extractions <- extractions %>%
  mutate_if(is.factor, as.character) %>%
  select(Label_ID, original_sample)

# write out complete csv for use in next script
write.table(extractions,
            file = "output/metadata_tables/groupfile.tsv",
            sep = "\t",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE)
