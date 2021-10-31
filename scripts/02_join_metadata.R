# R script to create metadata file for analysis from sub-culturing
# worksheets and write out for later use by the next script

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017
# Updated October 29, 2021

# load packages
library("dplyr")


# load data
cultures <- read.csv("data/metadata/culturing_worksheet_emma.csv",
                      stringsAsFactors = FALSE)

extractions <- read.csv("data/metadata/extraction_worksheet_emma.csv",
                        stringsAsFactors = FALSE)

trees <- read.csv("data/metadata/m_excel_tree_metadata_with_isolationfreq.csv",
                  stringsAsFactors = FALSE)

vouchers <- read.csv("data/metadata/water_voucher_worksheet_emma.csv",
                     stringsAsFactors = FALSE)

seq_ids_passing_checks <- read.table("output/mothur_pipeline/05_seq_names.txt",
                                     col.names = "seq_id")

# get rid of data entry typo row
extractions <- extractions[extractions$Culture_Label_ID != "ZUSF002481", ]

# function to check if a parent exists
# 'exists' in this case means was part of this project and so is
# included in the metadata files
check_if_parent_exists <- function(parent_culture) {
  
  # if the parent is missing from the matching below, then it will
  # return a character vector of length 0, which we check for here
  if (length(parent_culture) > 0) {
    return(parent_culture)
  }
  else {
    return("Not found")
  }
}

# look up the culture a voucher came from in the voucher table
find_culture_for_voucher <- function(voucher_id) {
  check_if_parent_exists(vouchers$Label_ID_culture[
    vouchers$Label_ID_Voucher == voucher_id])
}

# goal is to find the highest level parent of a given culture
# we accomplish this for an arbitrary number of parents using a
# recursive function
find_top_level_parent <- function(culture_id) {
  
  # if it comes from a voucher, need to use the function for that
  if (grepl(pattern = "VUSF", x = culture_id)) {
    find_top_level_parent(find_culture_for_voucher(culture_id))
  }
  
  # if the culture exists, find its parent
  else if (culture_id %in% cultures$Label_ID) {
    find_top_level_parent(
      check_if_parent_exists(cultures[
        cultures$Label_ID == culture_id, "From_Label_ID"]))
  }
  else {
      return(culture_id)     
  }
}

# test to make sure the function works
stopifnot(find_top_level_parent("ZUSF02440") == "S5T3")
stopifnot(find_top_level_parent("ZUSF02680") == "S5T3")
stopifnot(find_top_level_parent("ZUSF02675") == "Not found")

# populate parent column with NAs to start
extractions$original_sample <- NA

# recursively look up top-level parent of each culture and add to parent column
for (i in seq_len(nrow(extractions))) {
  # because the data are messy we need to first check only for those culture
  # IDs that match the proper naming convention
  if (grepl(pattern = "^ZUSF[0-9]{5}", x = extractions$Culture_Label_ID[i]) &

      # and then we also need to check that they don't occur multiple times
      # in the culturing sheet (due to typos)
      (!extractions$Culture_Label_ID[i] %in%
       cultures$Label_ID[duplicated(cultures$Label_ID)])) {

    # if both of those conditions are met, then find the parent of the culture
    # using the recursive look up function defined above and assign into the
    # column 'original_sample' in the extractions data frame
    extractions$original_sample[i] <-
      find_top_level_parent(
        extractions$Culture_Label_ID[i])
  }
}

# Manually set name for USF testing sample
extractions$original_sample[
  extractions$original_sample == "Test Sample"] <- "Test_Sample"

# select out columns of interest and filter out unneeded rows
# both those that aren't from this study as well as those extractions
# that were not successfully sequenced
extractions <- extractions %>%
  select(Label_ID, original_sample) %>%
  filter(original_sample != "Not found") %>%
  filter(original_sample != "Test_Sample") %>%
  filter(Label_ID %in% seq_ids_passing_checks$seq_id)

# write out complete tsv for use in next script
write.table(extractions,
            file = "output/metadata_tables/groupfile.tsv",
            sep = "\t",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE)
