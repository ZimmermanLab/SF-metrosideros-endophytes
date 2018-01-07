#!/bin/bash

# Draft of bash script to clean ITS fasta sequences
# and cluster them using mothur

# Originally written by Naupaka Zimmerman
# nzimmerman@usfca.edu
# August 24, 2017

## TODO: Need to add echo statements to let use know what is happening
## TODO: Need to adjust paths to new directory structure, or use ARGV

# combine all individual fasta files into single combined fasta
cat *.fasta > all_seqs.fasta

# count number of non-failed sequences
# need to install bioawk if it is not already installed
bioawk -c fastx '!/FAILED/ && !/FALIED/ {print ">"$name"\n"$seq}' all_seqs.fasta | grep -c ">"

# get rid of failed sequences and all but first EUSF00001 sequence
bioawk -c fastx '!/FAILED/ && !/FALIED/ && !/EUSF00001_ITS1F_[BG]/ {print ">"$name"\n"$seq}' all_seqs.fasta > good_seqs.fasta

# check if all sequence names are unique
sed 's/>\(.*\)_ITS1F.*/\1/' good_seqs.fasta | grep "EUSF" | sort | uniq -c | head

# Keep only sequence name
sed 's/>\(.*\)_ITS1F.*/>\1/' good_seqs.fasta > good_seqs_short_names.fasta

# check for success
head good_seqs_short_names.fasta

# clustering fails b/c also a double of 462
# looks like the two 462 sequences are completely different, dropping both
grep "EUSF" good_seqs_short_names.fasta | sort | uniq -c | sort | tail

# get rid of 462 sequence
bioawk -c fastx '!/EUSF00462/ {print ">"$name"\n"$seq}' good_seqs_short_names.fasta > good_seqs_short_names_checked.fasta

# cluster using vsearch
# need to install mothur if it is not already installed
mothur "#cluster(fasta=good_seqs_short_names_checked.fasta, method=agc);"

mothur "#bin.seqs(list=good_seqs_short_names_checked.agc.list, fasta=good_seqs_short_names_checked.fasta);"

grep ">" good_seqs_short_names_checked.agc.0.03.fasta | sed 's/>//' > seq_with_OTU_ID.txt
