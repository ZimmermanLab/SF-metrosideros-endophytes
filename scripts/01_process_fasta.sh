#!/bin/bash

# Draft of bash script to clean ITS fasta sequences
# and cluster them using mothur

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017

# Modified May 1, 2018 to reflect updated project dir structure
# Modified Dec 20, 2018 to allow for newer data to be incorporated

## TODO: Need to add echo statements to let use know what is happening
## TODO: Need to adjust paths to new directory structure, or use ARGV

# correct digits in old sequences
sed 's/EUSF0/EUSF00/' data/sequences/hand-cleaned_seqs/2017_august_hand_cleaned_seqs_not_including_failed.fasta > output/processed_sequence_files/aug_2017_seqs_corrected.fasta

# combine all individual fasta files into single combined fasta
# NOTE this does not include the first round of preliminary sampling at 3 sites
# that could be added by also including 2017_april_hand_cleaned_seqs_not_including_failed.fasta
# in the following statement
cat output/processed_sequence_files/aug_2017_seqs_corrected.fasta \
  data/sequences/hand-cleaned_seqs/new_seq_EG_thesis_cleaned.fasta > output/processed_sequence_files/all_seqs.fasta

# Fix all 4 digit EUSF identifiers and make 5 digit so joins and lookups will work
sed -r 's/>EUSF([0-9]{4})_(.*)/>EUSF0\1_\2/' output/processed_sequence_files/all_seqs.fasta > output/processed_sequence_files/all_seqs_std.fasta

# rename standardized file so subsequent steps will still work
mv output/processed_sequence_files/all_seqs_std.fasta output/processed_sequence_files/all_seqs.fasta

# count number of non-failed sequences
# need to install bioawk if it is not already installed
bioawk -c fastx '!/FAILED/ && !/FALIED/ {print ">"$name"\n"$seq}' output/processed_sequence_files/all_seqs.fasta | grep -c ">"

# get rid of failed sequences and all but first EUSF00001 sequence
bioawk -c fastx '!/FAILED/ && !/FALIED/ && !/EUSF00001_ITS1F_[BG]/ && !/EUSF01865_ITS1F_A09_cleaned/ {print ">"$name"\n"$seq}' output/processed_sequence_files/all_seqs.fasta > output/processed_sequence_files/good_seqs.fasta

# check if all sequence names are unique
sed 's/>\(.*\)_ITS1F.*/\1/' output/processed_sequence_files/good_seqs.fasta | grep "EUSF" | sort | uniq -c | head

# Keep only sequence name
sed 's/>\(.*\)_ITS1F.*/>\1/' output/processed_sequence_files/good_seqs.fasta > output/processed_sequence_files/good_seqs_short_names.fasta

# check for success
head output/processed_sequence_files/good_seqs_short_names.fasta

# clustering fails b/c also a double of 462
# looks like the two 462 sequences are completely different, dropping both
grep "EUSF" output/processed_sequence_files/good_seqs_short_names.fasta | sort | uniq -c | sort | tail

# get rid of 462 sequence
bioawk -c fastx '!/EUSF00462/ {print ">"$name"\n"$seq}' output/processed_sequence_files/good_seqs_short_names.fasta > output/processed_sequence_files/good_seqs_short_names_checked.fasta

# get rid of both 1917 sequences because they are two different sequences with the same identifier
bioawk -c fastx '!/EUSF01917/ {print ">"$name"\n"$seq}' output/processed_sequence_files/good_seqs_short_names.fasta > output/processed_sequence_files/good_seqs_short_names_checked.fasta

# make names file
bioawk -c fastx '// {print $name}' output/processed_sequence_files/good_seqs_short_names_checked.fasta > output/processed_sequence_files/seq_names.txt

# check again after cleaning, all should have 1s (be unique)
grep "EUSF" output/processed_sequence_files/good_seqs_short_names_checked.fasta | sort | uniq -c | sort | tail

# cd output/processed_sequence_files

# cluster using vsearch
# need to install mothur if it is not already installed
# Linux 64Bit Version
# Mothur version=1.39.5
# Release Date=3/20/2017
# also this step is pretty version specific -- new versions of mothurmay not work

mothur "#unique.seqs(fasta=good_seqs_short_names_checked.fasta, inputdir=./output/processed_sequence_files, outputdir=./output/processed_sequence_files)"

mothur "#cluster(fasta=good_seqs_short_names_checked.fasta, method=agc, inputdir=./output/processed_sequence_files, outputdir=./output/processed_sequence_files);"

mothur "#bin.seqs(list=good_seqs_short_names_checked.agc.list, fasta=good_seqs_short_names_checked.fasta, inputdir=./output/processed_sequence_files, outputdir=./output/processed_sequence_files);"

head -1 output/processed_sequence_files/good_seqs_short_names_checked.agc.list | cut -f 3- | sed 's/\t/\n/g' > output/processed_sequence_files/otu_temp.txt

head -2 output/processed_sequence_files/good_seqs_short_names_checked.agc.list | tail -1 | cut -f 3- | sed 's/\t/\n/g' > output/processed_sequence_files/seq_ids_temp.txt

# join these two colums together, then melt the second using perl
paste output/processed_sequence_files/otu_temp.txt output/processed_sequence_files/seq_ids_temp.txt |\
  perl -n -e 'chomp(); @_ = split(/\t/, $_); @seqs = split(/,/, @_[1]); foreach (@seqs) { print("$_\t@_[0]\n"); }' >\
  output/processed_sequence_files/seq_with_OTU_ID.txt

# sort to be able to join using bash 
sort output/processed_sequence_files/seq_with_OTU_ID.txt > output/processed_sequence_files/otu_seq_sorted.txt
sort output/processed_sequence_files/good_seqs_short_names_checked.names > output/processed_sequence_files/names_sorted.txt
join output/processed_sequence_files/otu_seq_sorted.txt output/processed_sequence_files/names_sorted.txt | cut -f 2- -d " " > output/processed_sequence_files/joined_otu_seqs.txt

# join these two colums together, then melt the second using perl
cat output/processed_sequence_files/joined_otu_seqs.txt | perl -n -e 'chomp(); @_ = split(/ /, $_); @seqs = split(/,/, @_[1]); foreach (@seqs) { print("$_\t@_[0]\n"); }' \
   > output/processed_sequence_files/seq_with_OTU_ID.txt
