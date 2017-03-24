FROM ubuntu:14.04

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN echo " \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \n\
" >/etc/apt/sources.list

RUN apt-get update && apt-get install -y git vim curl wget ssh gcc make build-essential ca-certificates zlib1g-dev software-properties-common

# install python
RUN apt-get install -y python-pip python2.7 python2.7-dev
RUN pip install pysam

# install java
RUN apt-get install -y openjdk-7-jdk
ENV _JAVA_OPTIONS -Djava.io.tmpdir=/haplox/tmp

# install R
RUN echo "deb http://mirrors.ustc.edu.cn/CRAN/bin/linux/ubuntu trusty/" >>/etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | sudo apt-key add -
RUN apt-get update
RUN apt-get -y install r-base
RUN Rscript -e 'install.packages("dplyr", repos="http://mirrors.ustc.edu.cn/CRAN/")' \
    && Rscript -e 'install.packages("stringr", repos="http://mirrors.ustc.edu.cn/CRAN/")' \
    && Rscript -e 'install.packages("plotrix", repos="http://mirrors.ustc.edu.cn/CRAN/")'

# install julia
RUN add-apt-repository -y ppa:staticfloat/juliareleases
RUN add-apt-repository -y ppa:staticfloat/julia-deps
RUN apt-get update
RUN apt-get install -y julia


RUN apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD bwa /usr/bin/


RUN pip install future
RUN apt-get update && apt-get upgrade -y
RUN sudo apt-get install -y libfreetype6-dev
RUN pip install cnvkit -i https://mirrors.aliyun.com/pypi/simple
ADD cnvkit.py /usr/local/bin/cnvkit.py


# install additional R packages using R
RUN > rscript.R \
    && echo 'source("https://bioconductor.org/biocLite.R")' >> rscript.R \
    && echo 'biocLite(ask=FALSE)' >> rscript.R \
    # &&echo 'biocLite("BiocUpgrade")' >> rscript.R \
    && echo 'biocLite("DNAcopy",ask=FALSE)' >> rscript.R \
    && Rscript rscript.R

# Cleanup
RUN rm rscript.R

RUN Rscript -e 'install.packages("PSCBS", repos="http://mirrors.ustc.edu.cn/CRAN/")'

# install pypy
RUN add-apt-repository ppa:pypy/ppa
RUN apt-get update
RUN apt-get install -y pypy pypy-dev

# ADD bedtools /usr/local/bin/
# ADD samtools /usr/local/bin/

ENTRYPOINT ["/usr/bin/python"]
