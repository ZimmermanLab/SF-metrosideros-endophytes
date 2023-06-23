# Urban biogeography of fungal endophytes across San Francisco

[![DOI](https://zenodo.org/badge/94378545.svg)](https://zenodo.org/badge/latestdoi/94378545)
[![License (for text): CC BY 4.0](https://img.shields.io/badge/License%20(for%20text)-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![License (for code):
MIT](https://img.shields.io/badge/License%20(for%20code)-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![License (for data):
CC0-1.0](https://img.shields.io/badge/License%20(for%20data)-CC0_1.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)


Repository of the code, data, and text for the manuscript "Urban biogeography of fungal endophytes across San Francisco" published in the scientific journal [PeerJ](https://peerj.com), written by Emma Gibson and Naupaka Zimmerman.

Use of Google Maps images follows the guidelines here:    
https://about.google/brand-resource-center/products-and-services/geo-guidelines/

## Steps to reproduce the analyses and generate the manuscript

1. You'll need to install [Docker](https://docs.docker.com/engine/install/) and [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) first if you don't have them already.
2. Then, clone the repository, build the image, and start a container with RStudio server.

```bash
git clone https://github.com/ZimmermanLab/SF-metrosideros-endophytes
cd SF-metrosideros-endophytes
docker build -t sfendos . 
docker run --rm -d -p 8787:8787 -e DISABLE_AUTH=true -e ROOT=true -v /home/rstudio/sfendos/renv sfendos
```

**OR**, if you have docker installed and want to use the prebuilt image from Docker Hub, it's even easier/faster:

```bash
docker run --rm -d -p 8787:8787 -e DISABLE_AUTH=true -e ROOT=true -v /home/rstudio/sfendos/renv naupaka/sfendos
```

3. Open http://localhost:8787 in your web browser.
4. Click on the `sfendos` directory in the file pane (lower right of the window), and then on the `SF-metrosideros-endophytes.Rproj` file to open the project.
5. Open a new bash terminal in the RStudio Server interface and type `make`.
6. Go get a cup of coffee (it still has to install a good number of LaTeX packages) and when you come back the manuscript should be built..

## Overview of files and directory structure

The directory structure is shown below. The most important files are the
raw data in the `data/` directory, the `gibson2023.Rmd` Rmarkdown file
that contains all of the text and a good bit of the code for the
manuscript, the `references.bib` file that contains the references for
the manuscript, and the scripts in the `scripts/` directory, which are
called by the Rmd file or the `Makefile` to run the pipeline. The
computational environment is specified by the `Dockerfile` and the
`renv.lock` file. The `output/` directory contains a number of
intermediate output files for the processing pipeline, and also includes
the R session info for the last time the manuscript was generated, in
`output/log_files/r_session_info.txt`. Other files that haven't been
mentioned are mostly ancillary files for generating the manuscript using
bookdown and LaTeX.


```
├── Dockerfile
├── LICENSE.md
├── Makefile
├── README.md
├── SF-metrosideros-endophytes.Rproj
├── data
│   ├── blast_results_for_unknowns
│   │   ├── EUSF00620-genbank-blastn-alignment-2021-10-31.txt
│   │   └── EUSF00664-genbank-blastn-alignment-2021-10-31.txt
│   ├── metadata
│   │   ├── culturing_worksheet_emma.csv
│   │   ├── extraction_worksheet_emma.csv
│   │   ├── m_excel_tree_metadata_with_isolationfreq.csv
│   │   ├── tbas_taxonomies.csv
│   │   └── water_voucher_worksheet_emma.csv
│   └── sequences
│       ├── hand-cleaned_seqs
│       └── new_zealand_sequence_search.csv
├── gibson2023.Rmd
├── gibson2023.fff
├── gibson2023.log
├── gibson2023.pdf
├── gibson2023.tex
├── gibson2023.ttt
├── gibson2023_files
│   └── figure-latex
│       ├── isolation-dbh-freq-plots-1.pdf
│       ├── nmds-plot-1.pdf
│       ├── rarefaction-plot-1.pdf
│       ├── site-map-1.pdf
│       └── taxonomy-by-site-plot-1.pdf
├── init_docker.sh
├── output
│   ├── log_files
│   │   ├── r_session_info.txt
│   │   └── seq_script_log.txt
│   ├── metadata_tables
│   │   ├── groupfile.tsv
│   │   ├── m_excel_tree_metadata_with_isolationfreq_wgs_lat_long.csv
│   │   └── tbas_with_site.csv
│   ├── mothur_pipeline
│   │   ├── 01_all_seqs.fasta
│   │   ├── 02_good_seqs.fasta
│   │   ├── 04_good_seqs_short_names_checked.agc.0.03.fasta
│   │   ├── 04_good_seqs_short_names_checked.agc.list
│   │   ├── 04_good_seqs_short_names_checked.count_table
│   │   ├── 04_good_seqs_short_names_checked.fasta
│   │   ├── 04_good_seqs_short_names_checked.names
│   │   ├── 04_good_seqs_short_names_checked.unique.fasta
│   │   ├── 05_seq_names.txt
│   │   ├── 06_otu_temp.txt
│   │   ├── 07_seq_ids_temp.txt
│   │   ├── 08_seq_with_OTU_ID.txt
│   │   ├── 09_otu_seq_sorted.txt
│   │   ├── 10_names_sorted.txt
│   │   ├── 11_joined_otu_seqs.txt
│   │   └── 12_seq_with_OTU_ID.txt
│   ├── sf_basemap.Rdata
│   └── tbas_output
│       ├── 2019-06-17_tbas21_archiveYIYORC5W_.tar.gz
│       └── 2019-06-17_tbas_run
├── peerj.csl
├── preamble.tex
├── references.bib
├── renv
│   ├── activate.R
│   └── settings.dcf
├── renv.lock
├── scripts
│   ├── 01_process_fasta.sh
│   ├── 02_join_metadata.R
│   ├── 03_make_otu_table.R
│   ├── 04_clean_and_join_tbas_taxonomy.R
│   └── 05_setup_maps_and_gis_coords.R
└── wlpeerj.cls

16 directories, 60 files
```
