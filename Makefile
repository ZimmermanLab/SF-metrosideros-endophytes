gibson2021.pdf : gibson2021.Rmd
	bash scripts/01_process_fasta.sh > output/log_files/seq_script_log.txt
	Rscript -e "rmarkdown::render('gibson2021.Rmd',  encoding = 'UTF-8')"