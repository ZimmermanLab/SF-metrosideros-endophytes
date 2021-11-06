# Urban biogeography of fungal endophytes across San Francisco

Repository for the manuscript "Urban biogeography of fungal endophytes across San Francisco" to be submitted to PeerJ.

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
6. Go get a cup of coffee (it still has to install a good number of LaTeX packages) and when you come back the manuscript should be built.