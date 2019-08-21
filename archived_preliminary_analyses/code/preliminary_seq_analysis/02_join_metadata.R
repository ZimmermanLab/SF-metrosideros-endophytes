# Draft of R script to create metadata file for analysis from subculturing
# worksheets and write out for later use by the next script

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017

## TODO: Fix paths for the files

# load library
library("dplyr")

# load data
culturing <- read.csv("data/2017-02-16_culturing_worksheet - Sheet1.csv")
extractions <- read.csv("data/Extraction_worksheet - Sheet1.csv")
trees <- read.csv("data/2017-06-09_M_excel_tree_metadata - Sheet1.csv")

# 4 levels of joining since we can't recursively join
joined <- extractions %>%
  left_join(culturing, by = c("Culture_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y" = "Label_ID")) %>%
  select(starts_with("From_Label_ID"))

# set NAs appropriately
joined[grepl(joined[, 1], pattern = "^Z"), 1] <- NA
joined[grepl(joined[, 2], pattern = "^Z"), 2] <- NA
joined[grepl(joined[, 3], pattern = "^Z"), 3] <- NA
joined[grepl(joined[, 4], pattern = "^Z"), 4] <- NA

# convert to character
joined$From_Label_ID <- as.character(joined$From_Label_ID)

# merge all together
joined$all <- joined$From_Label_ID.x  # your new merged column start with x
joined$all[!is.na(joined$From_Label_ID.y)] <- joined$From_Label_ID.y[!is.na(joined$From_Label_ID.y)]  # merge with y
joined$all[!is.na(joined$From_Label_ID.y.y)] <- joined$From_Label_ID.y.y[!is.na(joined$From_Label_ID.y.y)]  # merge with y
joined$all[!is.na(joined$From_Label_ID)] <- joined$From_Label_ID[!is.na(joined$From_Label_ID)]  # merge with y

# join now by Tree ID
joined_tree_ID <- extractions %>%
  left_join(culturing, by = c("Culture_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y" = "Label_ID")) %>%
  select(Label_ID) %>%
  cbind(all = joined$all) %>%
  na.omit()

# Manually set name for USF testing sample
levels(joined_tree_ID$all)[levels(joined_tree_ID$all) == "Test Sample"] <- "Test_Sample"

# fix zero padding errors in extraction IDs
joined_tree_ID <- joined_tree_ID %>%
  mutate_if(is.factor, as.character) %>%
  mutate(Label_ID = gsub("EUSF", "EUSF0", Label_ID))

# write out complete csv for use in next script
write.table(joined_tree_ID,
            file = "data/groupfile.tsv",
            sep = "\t",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE)
