R_SCRIPTS					:= $(wildcard scripts/*.R)
SEQS_IN						:= $(data/sequences/hand-cleaned_seqs/*.fasta)
SEQS_OUT_DIR			:= output/mothur_pipeline
METADATA_IN_DIR		:= data/metadata
METADATA_FILES		:= $(wildcard data/metadata/*.csv)
METADATA_OUT_DIR	:= output/metadata_tables

all: gibson2021.pdf

# render pdf with rmarkdown -> tex -> pdf
gibson2021.pdf: gibson2021.Rmd preamble.tex wlpeerj.cls references.bib \
								$(R_SCRIPTS) $(METADATA_FILES) \
								$(METADATA_OUT_DIR)/groupfile.tsv \
								$(SEQS_OUT_DIR)/05_seq_names.txt \
								$(SEQS_OUT_DIR)/12_seq_with_OTU_ID.txt \
								$(METADATA_OUT_DIR)/m_excel_tree_metadata_with_isolationfreq_wgs_lat_long.csv
	Rscript -e "rmarkdown::render('gibson2021.Rmd',  encoding = 'UTF-8')"

# reproject GIS coordinates and add to tree metadatafile
$(METADATA_OUT_DIR)/m_excel_tree_metadata_with_isolationfreq_wgs_lat_long.csv: \
		scripts/05_setup_maps_and_gis_coords.R \
		$(METADATA_IN_DIR)/m_excel_tree_metadata_with_isolationfreq.csv
	Rscript scripts/05_setup_maps_and_gis_coords.R

# clean tbas taxonomic information and add site data
$(METADATA_OUT_DIR)/tbas_with_site.csv: scripts/04_clean_and_join_tbas_taxonomy.R \
		$(METADATA_OUT_DIR)/groupfile.tsv $(METADATA_IN_DIR)/tbas_taxonomies.csv
	Rscript scripts/04_clean_and_join_tbas_taxonomy.R

# determine each extraction's original tree sample ID using recursion
$(METADATA_OUT_DIR)/groupfile.tsv: scripts/02_join_metadata.R \
		$(SEQS_OUT_DIR)/05_seq_names.txt $(METADATA_FILES)
	Rscript scripts/02_join_metadata.R

# process seqs to get clean list with OTU assignment via mothur
$(SEQS_OUT_DIR)/12_seq_with_OTU_ID.txt: scripts/01_process_fasta.sh $(SEQS_IN) \
		$(METADATA_IN_DIR)/extraction_worksheet_emma.csv
	bash scripts/01_process_fasta.sh > output/log_files/seq_script_log.txt

# process sequences to get clean list of names
$(SEQS_OUT_DIR)/05_seq_names.txt: scripts/01_process_fasta.sh $(SEQS_IN) \
		$(METADATA_IN_DIR)/extraction_worksheet_emma.csv
	bash scripts/01_process_fasta.sh > output/log_files/seq_script_log.txt

clean:
	rm -fv output/log_files/*
	rm -fv output/mothur_pipeline/*
	rm -fv gibson2021_files/figure-latex/*.pdf
	rm -fv gibson2021.tex gibson2021.fff gibson2021.ttt gibson2021.pdf

.PHONY: clean all