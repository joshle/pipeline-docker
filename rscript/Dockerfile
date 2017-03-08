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
ENV R_BASE_VERSION 3.3.2

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
RUN Rscript -e 'install.packages("dplyr",dependencies=TRUE)' \
	&&Rscript -e 'install.packages("stringr",dependencies=TRUE)'


ADD bwa /usr/bin/


ENTRYPOINT ["/usr/bin/python"]
