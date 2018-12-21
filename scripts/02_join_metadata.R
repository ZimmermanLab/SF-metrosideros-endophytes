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

stopifnot(find_top_level_parent_of_culture("ZUSF02440") == "S5T3")

# 4 levels of joining since we can't recursively join
joined <- extractions %>%
  left_join(culturing, by = c("Culture_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y.y.y" = "Label_ID")) %>%
    select(starts_with("From_Label_ID"))

# set NAs appropriately
joined[grepl(joined[, 1], pattern = "^Z"), 1] <- NA
joined[grepl(joined[, 2], pattern = "^Z"), 2] <- NA
joined[grepl(joined[, 3], pattern = "^Z"), 3] <- NA
joined[grepl(joined[, 4], pattern = "^Z"), 4] <- NA
joined[grepl(joined[, 5], pattern = "^Z"), 5] <- NA
joined[grepl(joined[, 6], pattern = "^Z"), 6] <- NA

# convert to character
joined$From_Label_ID <- as.character(joined$From_Label_ID)

# merge all together
joined$all <- joined$From_Label_ID.x  # your new merged column start with x
joined$all[!is.na(joined$From_Label_ID.y)] <- joined$From_Label_ID.y[!is.na(joined$From_Label_ID.y)]  # merge with y
joined$all[!is.na(joined$From_Label_ID.y.y)] <- joined$From_Label_ID.y.y[!is.na(joined$From_Label_ID.y.y)]  # merge with y
joined$all[!is.na(joined$From_Label_ID.y.y.y)] <- joined$From_Label_ID.y.y[!is.na(joined$From_Label_ID.y.y.y)]
joined$all[!is.na(joined$From_Label_ID.y.y.y.y)] <- joined$From_Label_ID.y.y[!is.na(joined$From_Label_ID.y.y.y.y)]
joined$all[!is.na(joined$From_Label_ID)] <- joined$From_Label_ID[!is.na(joined$From_Label_ID)]  # merge with y

# join now by Tree ID
joined_tree_ID <- extractions %>%
  left_join(culturing, by = c("Culture_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y.y.y" = "Label_ID")) %>%
  select(Label_ID) %>%
  cbind(all = joined$all) %>%
  na.omit()

# Manually set name for USF testing sample
levels(joined_tree_ID$all)[levels(joined_tree_ID$all) == "Test Sample"] <- "Test_Sample"

# fix zero padding errors in extraction IDs
joined_tree_ID <- joined_tree_ID %>%
  mutate_if(is.factor, as.character) %>%
  mutate(Label_ID = gsub("EUSF0", "EUSF", Label_ID))

# write out complete csv for use in next script
write.table(joined_tree_ID,
            file = "output/processed_sequence_files/groupfile.tsv",
            sep = "\t",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE)

