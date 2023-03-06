R_SCRIPTS					:= $(wildcard scripts/*.R)
METADATA_FILES		:= $(wildcard data/metadata/*.csv)
SEQS_IN						:= $(data/sequences/hand-cleaned_seqs/*.fasta)
METADATA_IN_DIR		:= data/metadata

all: gibson2023.pdf

# render pdf with rmarkdown -> tex -> pdf
gibson2023.pdf: gibson2023.Rmd preamble.tex wlpeerj.cls references.bib \
								$(R_SCRIPTS) $(METADATA_FILES) otus
	Rscript -e "rmarkdown::render('gibson2023.Rmd',  encoding = 'UTF-8')"

# process sequences to get clean list of names
otus: scripts/01_process_fasta.sh $(SEQS_IN) \
		$(METADATA_IN_DIR)/extraction_worksheet_emma.csv
	bash scripts/01_process_fasta.sh > output/log_files/seq_script_log.txt

clean:
	rm -fv output/log_files/*
	rm -fv output/mothur_pipeline/*
	rm -fv gibson2023_files/figure-latex/*.pdf
	rm -fv gibson2023.tex gibson2023.fff gibson2023.ttt gibson2023.pdf gibson2023.log

.PHONY: clean otus all