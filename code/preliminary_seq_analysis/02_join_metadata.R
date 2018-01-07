library("dplyr")

culturing <- read.csv("2017-02-16_culturing_worksheet - Sheet1.csv")
extractions <- read.csv("Extraction_worksheet - Sheet1.csv")
trees <- read.csv("2017-06-09_M_excel_tree_metadata - Sheet1.csv")

joined <- extractions %>%
  left_join(culturing, by = c("Culture_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y" = "Label_ID")) %>%
  select(starts_with("From_Label_ID"))

joined[grepl(joined[, 1], pattern = "^Z"), 1] <- NA
joined[grepl(joined[, 2], pattern = "^Z"), 2] <- NA
joined[grepl(joined[, 3], pattern = "^Z"), 3] <- NA
joined[grepl(joined[, 4], pattern = "^Z"), 4] <- NA

joined$From_Label_ID <- as.character(joined$From_Label_ID)

joined$all <- joined$From_Label_ID.x  # your new merged column start with x
joined$all[!is.na(joined$From_Label_ID.y)] <- joined$From_Label_ID.y[!is.na(joined$From_Label_ID.y)]  # merge with y
joined$all[!is.na(joined$From_Label_ID.y.y)] <- joined$From_Label_ID.y.y[!is.na(joined$From_Label_ID.y.y)]  # merge with y
joined$all[!is.na(joined$From_Label_ID)] <- joined$From_Label_ID[!is.na(joined$From_Label_ID)]  # merge with y

joined_tree_ID <- extractions %>%
  left_join(culturing, by = c("Culture_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y" = "Label_ID")) %>%
  left_join(culturing, by = c("From_Label_ID.y.y" = "Label_ID")) %>%
  select(Label_ID) %>%
  cbind(all = joined$all) %>%
  na.omit()

levels(joined_tree_ID$all)[levels(joined_tree_ID$all) == "Test Sample"] <- "Test_Sample"

joined_tree_ID <- joined_tree_ID %>%
  mutate_if(is.factor, as.character) %>%
  mutate(Label_ID = gsub("EUSF", "EUSF0", Label_ID))
  
write.table(joined_tree_ID, 
            file = "groupfile.tsv", 
            sep = "\t", 
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE)

