#!/bin/bash

#Emma Gibson, February 22, 2018
#a quick, temporary script to count the species abundances in preliminary sequences

#make a file that summarizes the biggest groups in the preliminary dataset
echo "counting most abundant species..."
cut -d, -f1 BLAST_results/prelim_BLAST.csv | sort | uniq -c | sort -n > BLAST_results/2018-02-20_prelim_BLAST_summary.txt
echo "finished counting most abundant species"
