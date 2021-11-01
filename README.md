# Urban biogeography of fungal endophytes across San Francisco

Repository for the manuscript "Urban biogeography of fungal endophytes across San Francisco" to be submitted to PeerJ.

Use of Google Maps images follows the guidelines here:    
https://about.google/brand-resource-center/products-and-services/geo-guidelines/

## Steps to reproduce the analyses and generate the manuscript

1. You'll need to install Docker and git first if you don't have them already.
2. Then, clone the repository, build the image, and start a container with RStudio server.

```bash
git clone https://github.com/ZimmermanLab/SF-metrosideros-endophytes
cd SF-metrosideros-endophytes
docker build -t sfendos . 
docker run --rm -d -p 8787:8787 -e DISABLE_AUTH=true -e ROOT=true -v $(pwd):/home/rstudio/sfendos -v /home/rstudio/sfendos/renv sfendos
```

3. Open http://localhost:8787 in your web browser.
4. Click on the `sfendos` directory in the file pane, and then on the `SF-metrosideros-endophytes.Rproj` file to open the project.
5. Open a new terminal and type `make`.
6. Go get a cup of coffee and when you come back the manuscript should be built.