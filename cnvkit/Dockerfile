FROM ubuntu:16.04
MAINTAINER Eric Talevich <eric.talevich@ucsf.edu>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    cython \
    libfreetype6-dev \
    python-biopython \
    python-dev \
    python-matplotlib \
    python-numpy \
    python-pip \
    python-reportlab \
    python-scipy \
    python-tk \
    r-base-core \
    zlib1g-dev
RUN pip install pandas pysam pyvcf pyfaidx
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite('PSCBS', 'cghFLasso')"
RUN pip install cnvkit==0.7.11

ENTRYPOINT ["cnvkit.py"]
CMD ["--help"]
# CMD ["bash"]
