# Draft of R script to create metadata file for analysis from subculturing
# worksheets and write out for later use by the next script

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017

## TODO: Fix paths for the files

# load library
library("dplyr")

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
find_top_level_parent_of_culture <- function(culture_id) {
  if (culture_id %in% culturing$Label_ID) {
    find_top_level_parent_of_culture(
      culturing[culturing$Label_ID == culture_id, "From_Label_ID"])
  }
  else {
    return(culture_id)
  }
}

# test to make sure it works
stopifnot(find_top_level_parent_of_culture("ZUSF02440") == "S5T3")

find_top_level_parent_of_culture("ZUSF00641")

extractions$original_sample <- NA

for (i in 1:nrow(extractions)) {
  # because the data are messy we need to first check only for those culture
  # IDs that match the proper naming convention
  if (grepl(pattern = "^ZUSF[0-9]{5}", x = extractions$Culture_Label_ID[i]) &
      
      # and then we also need to check that they don't occur multiple times
      # in the culturing sheet (due to typos)
      (!extractions$Culture_Label_ID[i] %in%
       culturing$Label_ID[duplicated(culturing$Label_ID)])) {
    
    # if both of those ocnditions are met, then find the parent of the culture
    # using the recursive lookup function defined above and assign into the
    # column 'original_sample' in the extractions data frame
    extractions$original_sample[i] <-
      find_top_level_parent_of_culture(
        extractions$Culture_Label_ID[i])
  }
}

# Manually set name for USF testing sample
extractions$original_sample[extractions$original_sample == "Test Sample"] <-
  "Test_Sample"

# fix zero padding errors in extraction IDs
extractions <- extractions %>%
  mutate_if(is.factor, as.character) %>%
  mutate(Label_ID = gsub("EUSF0", "EUSF", Label_ID)) %>%
  select(Label_ID, original_sample)

# write out complete csv for use in next script
write.table(extractions,
            file = "output/processed_sequence_files/groupfile.tsv",
            sep = "\t",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE)

