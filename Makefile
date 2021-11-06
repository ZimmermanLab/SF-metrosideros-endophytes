R_SCRIPTS					:= $(wildcard scripts/*.R)
METADATA_FILES		:= $(wildcard data/metadata/*.csv)
SEQS_IN						:= $(data/sequences/hand-cleaned_seqs/*.fasta)
METADATA_IN_DIR		:= data/metadata

all: gibson2021.pdf

# render pdf with rmarkdown -> tex -> pdf
gibson2021.pdf: gibson2021.Rmd preamble.tex wlpeerj.cls references.bib \
								$(R_SCRIPTS) $(METADATA_FILES) otus
	Rscript -e "rmarkdown::render('gibson2021.Rmd',  encoding = 'UTF-8')"

# process sequences to get clean list of names
otus: scripts/01_process_fasta.sh $(SEQS_IN) \
		$(METADATA_IN_DIR)/extraction_worksheet_emma.csv
	bash scripts/01_process_fasta.sh > output/log_files/seq_script_log.txt

clean:
	rm -fv output/log_files/*
	rm -fv output/mothur_pipeline/*
	rm -fv gibson2021_files/figure-latex/*.pdf
	rm -fv gibson2021.tex gibson2021.fff gibson2021.ttt gibson2021.pdf gibson2021.log

.PHONY: clean otus all