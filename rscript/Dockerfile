from daocloud.io/joshle/pipeline-docker:master

RUN pip install pysam

# File Author / Maintainer
MAINTAINER Douglas McCloskey <dmccloskey87@gmail.com>

## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

#ENV R_BASE_VERSION 3.2.3
ENV R_BASE_VERSION 3.3.1

# Install R
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
	&& apt-get -qq update \
	&& apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends \
		littler \
		r-base-core=${R_BASE_VERSION}* \
		r-base-dev=${R_BASE_VERSION}* \
#		r-recommended=${R_BASE_VERSION}* \
		libcurl4-openssl-dev \
		libxml2-dev \
		libfftw3-dev \
		git \
		wget \
        && echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
        && echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r \
	&& ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r \
	&& ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r \
	&& ln -s /usr/share/doc/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
	&& ln -s /usr/share/doc/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
	&& install.r docopt \
	&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
	&& rm -rf /var/lib/apt/lists/*

# install R packages
RUN Rscript -e 'install.packages("devtools",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("e1071",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("Amelia",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("mixOmics",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("pls",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("spls",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("caret",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("coin",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("rpart",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("e1071",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("class",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("cluster",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("randomForest",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("DAAG",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("boot",dependencies=TRUE)' \

## install devtools using R
	&&Rscript -e 'install.packages("devtools")'

## install additional R packages using R
RUN > rscript.R \
	&&echo 'source("https://bioconductor.org/biocLite.R")' >> rscript.R \
	&&echo 'biocLite(ask=FALSE)' >> rscript.R \
	#&&echo 'biocLite("BiocUpgrade")' >> rscript.R \
	&&echo 'biocLite("Biobase",ask=FALSE)' >> rscript.R \
	&&echo 'biocLite("LMGene",ask=FALSE)' >> rscript.R \
	&&echo 'biocLite("pcaMethods",ask=FALSE)' >> rscript.R \
	&&echo 'biocLite("ropls",ask=FALSE)' >> rscript.R \
	&&echo 'biocLite("topGO",ask=FALSE)' >> rscript.R \
	&&Rscript rscript.R


ADD bwa /usr/bin/


ENTRYPOINT ["/usr/bin/python"]
