#!/bin/bash

set -eou pipefail

# bash script to clean ITS fasta sequences
# and cluster them using mothur

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017

# Modified May 1, 2018 to reflect updated project dir structure
# Modified Dec 20, 2018 to allow for newer data to be incorporated
# Modified October 29, 2021 for submission to PeerJ
echo "Beginning sequence processing"

echo -e "\n####################################################################################\n"

# combine all individual fasta files into single combined fasta
# NOTE this does not include the first round of preliminary sampling at 3 sites
# because those were sampled much earlier and are not directly comparable
# that could be added by also including 2017_april_hand_cleaned_seqs_not_including_failed.fasta
# in the following statement
echo "Combining all sequences into output/processed_sequence_files/all_seqs.fasta"
cat data/sequences/hand-cleaned_seqs/2017_august_hand_cleaned_seqs_not_including_failed.fasta \
  data/sequences/hand-cleaned_seqs/new_seq_EG_thesis_cleaned.fasta > \
  output/mothur_pipeline/01_all_seqs.fasta
head output/mothur_pipeline/01_all_seqs.fasta

echo -e "\n####################################################################################\n"

echo "Setting working directory to output/mothur_pipeline"
cd output/mothur_pipeline

echo -e "\n####################################################################################\n"

# Fix all 4 digit EUSF identifiers and make 5 digit so joins and lookups will work
echo "Fixing any remaining 4 digit sequence identifiers and replacing with 5 digits to match others..." 
sed -r 's/>EUSF([0-9]{4})_(.*)/>EUSF0\1_\2/' 01_all_seqs.fasta > \
  02_all_seqs_std.fasta
head 02_all_seqs_std.fasta

echo -e "\n####################################################################################\n"

# rename standardized file so subsequent steps will still work (can't do earlier because it would overwrite)
mv -v 02_all_seqs_std.fasta 01_all_seqs.fasta

echo -e "\n####################################################################################\n"

# count number of non-failed sequences
# need to install bioawk if it is not already installed
echo "The number of sequences is:"
grep -c ">" 01_all_seqs.fasta

echo -e "\n####################################################################################\n"

# get rid of failed sequences and all but first EUSF00001 sequence (these were from testing)
echo "Removing any remaining duplicates or failed sequences..."
echo "Creating good_seqs.fasta"
bioawk -c fastx '!/FAILED/ && !/FALIED/ && !/mixed/ && !/failed/ && !/EUSF00001_ITS1F_[BG]/ && !/EUSF01865_ITS1F_A09_cleaned/ {print ">"$name"\n"$seq}' \
  01_all_seqs.fasta > \
  02_good_seqs.fasta
head 02_good_seqs.fasta

echo -e "\n####################################################################################\n"

# count number of remaining sequences
echo "The number of remaining sequences is:"
grep -c ">" 02_good_seqs.fasta

echo -e "\n####################################################################################\n"

echo "Next we need to remove any sequences not part of the current project"

# keep only sequences from the current project (Emma's sequences)
# first pull out the column of DNA extraction IDs
# turn this from a column into a | delimited set of IDs
# and remove the last one
EXTIDS=$(tail +2 ../../data/metadata/extraction_worksheet_emma.csv | \
  cut -d, -f2 | tr '\n' '|' | sed 's/|$//')

# output only sequences from Emma's extractions (the others are from other projects)
bioawk -c fastx -v pattern="$EXTIDS" \
  '$0~pattern { print ">"$name"\n"$seq}' 02_good_seqs.fasta > 02_good_seqs_proj.fasta
  
mv -v 02_good_seqs_proj.fasta 02_good_seqs.fasta

# count number of remaining sequences
echo "The number of remaining sequences is:"
grep -c ">" 02_good_seqs.fasta
  
echo -e "\n####################################################################################\n"

# check if all sequence names are unique
echo "Checking to see if all sequence names are unique (no more than 1 copy of each listed below)"
grep "EUSF" 02_good_seqs.fasta | sort | uniq -c

echo -e "\n####################################################################################\n"

# Keep only sequence name
echo "Removing unnecessary parts of sequence headers..."
echo "Creating 03_good_seqs_short_names.fasta"
sed 's/>\(.*\)_ITS1F.*/>\1/' 02_good_seqs.fasta > \
  03_good_seqs_short_names.fasta
head 03_good_seqs_short_names.fasta

echo -e "\n####################################################################################\n"

# check for success
echo "Check that sequence identifiers look clean in good_seqs_short_names.fasta"
grep ">" 03_good_seqs_short_names.fasta | sort

echo -e "\n####################################################################################\n"

# looking for any remaining duplicates with the trimmed names
echo "Checking for any remaining duplicates after trimming names..."
grep "EUSF" 03_good_seqs_short_names.fasta | sort | uniq -c | sort -n | tail


# get rid of both 1917 sequences because they are two different sequences with the same identifier
echo "Removing duplicate sequence ID 1917"
bioawk -c fastx '!/EUSF01917/ {print ">"$name"\n"$seq}' \
  03_good_seqs_short_names.fasta > \
  04_good_seqs_short_names_checked.fasta

echo "Confirming that they are removed--there should be no lines returned here:"
echo "$(grep 'EUSF01917' 04_good_seqs_short_names_checked.fasta)"

echo -e "\n####################################################################################\n"

# count number of non-failed sequences
echo "The number of remaining sequences is:"
grep -c ">" 04_good_seqs_short_names_checked.fasta

echo -e "\n####################################################################################\n"

# check again after cleaning, all should have 1s (be unique)
echo "Checking again for any duplicates after cleaning, this should return all 1s"
grep "EUSF" 04_good_seqs_short_names_checked.fasta | \
  sort | uniq -c | sort -n | tail

echo -e "\n####################################################################################\n"

# make names file
echo "Creating names file seq_names.txt"
bioawk -c fastx '{print $name}' \
  04_good_seqs_short_names_checked.fasta > \
  05_seq_names.txt
head 05_seq_names.txt

echo -e "\n####################################################################################\n"

# cluster using vsearch
# need to install mothur if it is not already installed
# Linux 64Bit Version
# Mothur version=1.39.5 (this is set in the Dockerfile for this project)
# Release Date=3/20/2017
# this step is pretty version specific -- new versions of mothur may not work

echo "Running the following steps with mothur v. 1.39.5"
echo "unique.seqs then cluster then bin.seqs"

mothur "#unique.seqs(fasta=04_good_seqs_short_names_checked.fasta, inputdir=./, outputdir=./);"
mothur "#cluster(fasta=04_good_seqs_short_names_checked.fasta, method=agc, inputdir=./, outputdir=./);"
mothur "#bin.seqs(list=04_good_seqs_short_names_checked.agc.list, fasta=04_good_seqs_short_names_checked.fasta, inputdir=./, outputdir=./);"

echo -e "\n####################################################################################\n"

echo "Pulling out list of OTU names/numbers from mothur output and storing into output/mothur_output/otu_temp.txt"
head -1 04_good_seqs_short_names_checked.agc.list | \
  cut -f 3- | sed 's/\t/\n/g' > 06_otu_temp.txt
head 06_otu_temp.txt

echo -e "\n####################################################################################\n"

echo "Pulling out list of sequence names for each OTU from mothur output and storing into output/mothur_output/seq_ids_temp.txt"
head -2 04_good_seqs_short_names_checked.agc.list | \
  tail -1 | cut -f 3- | sed 's/\t/\n/g' > 07_seq_ids_temp.txt
head 07_seq_ids_temp.txt

echo -e "\n####################################################################################\n"

# join these two colums together, then melt the second using perl
echo "Joining the two datasets together (OTU IDs and sequence IDs in each OTU cluster)"
echo "Melting the sequence IDs with perl"
echo "Storing the output into output/mothur_output/seq_with_OTU_ID.txt"
paste 06_otu_temp.txt 07_seq_ids_temp.txt |\
  perl -n -e 'chomp(); @_ = split(/\t/, $_); @seqs = split(/,/, @_[1]); foreach (@seqs) { print("$_\t@_[0]\n"); }' >\
  08_seq_with_OTU_ID.txt
head 08_seq_with_OTU_ID.txt

echo -e "\n####################################################################################\n"

# sort to be able to join using bash
echo "Sort both files and then join the columns using bash"
sort 08_seq_with_OTU_ID.txt > 09_otu_seq_sorted.txt
sort 04_good_seqs_short_names_checked.names > 10_names_sorted.txt
join 09_otu_seq_sorted.txt 10_names_sorted.txt | \
  cut -f 2- -d " " > 11_joined_otu_seqs.txt
head 11_joined_otu_seqs.txt

echo -e "\n####################################################################################\n"

# join these two colums together, then melt the second using perl
perl -n -e 'chomp(); @_ = split(/ /, $_); @seqs = split(/,/, @_[1]); foreach (@seqs) { print("$_\t@_[0]\n"); }' \
  11_joined_otu_seqs.txt \
   > 12_seq_with_OTU_ID.txt
head 12_seq_with_OTU_ID.txt

# move logfiles
echo "Moving mothur logfiles to logfiles directory"
mv mothur*logfile ../log_files

# return up
cd ../..
