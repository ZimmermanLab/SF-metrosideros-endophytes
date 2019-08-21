#!/bin/bash

#Emma Gibson, Feb 21, 2018
#a quick preliminary script to analyze sequence data

# check for BLASTDB variable, and sets appropriate variables if there isn't one
if [ -z ${BLASTDB} ]; then source /home/.bashrc; export PATH; export BLASTDB; fi

#make BLAST directory
mkdir BLAST_results

# search BLAST for sequence matches for cleaned .fastas
echo "searching BLAST database for sequence..."
blastn -db nt -num_threads 12 -outfmt '10 sscinames std' -out BLAST_results/prelim_BLAST.csv -max_target_seqs 1 -negative_gilist /blastdb/2017-09-21_GenBank_Environmental_Uncultured_to_Exclude.txt -query data/preliminary_trimmed_seqs.fasta
echo "searched BLAST database for sequence matches"
