FROM       rocker/geospatial
MAINTAINER Naupaka Zimmerman "https://github.com/naupaka"

RUN apt-get update
RUN apt-get install -y openssh-server tmux nano git unzip \
    bison byacc curl wget tar make gcc libz-dev shellcheck

##### bioawk #####
RUN mkdir -p /home/code/tools \
 && cd /home/code/tools; git clone git://github.com/lh3/bioawk.git \
 && cd /home/code/tools/bioawk; make


##### mothur #####
RUN curl -L https://github.com/mothur/mothur/releases/download/v1.39.5/Mothur.linux_64_static.zip -o /home/Mothur.linux_64_static.zip \
 && unzip /home/Mothur.linux_64_static.zip -d /home
 
 
###### R Packages ######
COPY . /home/manuscript
WORKDIR /home/manuscript

ENV RENV_VERSION 0.14.0
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
RUN R -e 'renv::restore()'


##### Other misc #####
COPY init_docker.sh /
WORKDIR /home

RUN echo "export PATH=${PATH}:/home/code/tools/sratoolkit.2.11.1-ubuntu64/bin/:/home/code/tools/bioawk/:/home/mothur" >> /home/.profile
RUN echo "/usr/bin/bash" >> /home/.profile

CMD ["/init_docker.sh"]

# mosh 3838
EXPOSE 22 8787
