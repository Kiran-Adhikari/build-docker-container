# Dockerfile for variant-calling

# start with Ubuntu
# FROM ubuntu
FROM --platform=linux/amd64 ubuntu bash

# install dependencies (here -y will not ask )
RUN apt-get update && apt-get install -y \
wget \
nano \
openssl

#install packages
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN mkdir /root/miniconda3

# telling miniconda run in bash 
###RUN bash Miniconda3-latest-Linux-x86_64.sh -b -u -p ~/miniconda3

RUN bash Miniconda3-latest-Linux-x86_64.sh -b -u -p /root/miniconda3

## == after we exit out from terminal go back to the docker and start the right Dockerfile
##3 come back to the terminal and type === docker exec it NAMEOFCONTAINER bash

#RUN ~/miniconda3/bin/conda init bash
RUN /root/miniconda3/bin/conda init bash
RUN rm Miniconda3-latest-Linux-x86_64.sh

## Install software
RUN ~/miniconda3/bin/conda install -c bioconda fastqc -y
RUN ~/miniconda3/bin/conda install -c bioconda trimmomatic -y
RUN ~/miniconda3/bin/conda install -c bioconda bwa -y
RUN ~/miniconda3/bin/conda install -c bioconda samtools -y
RUN ~/miniconda3/bin/conda install -c bioconda bcftools -y

### which fastqc   === to ckeck which one installed properly. 
### name -version === to check version   

# start with bash
CMD ["/bin/sh", "-c", "exec bash"]

### to bulit new container in docker for same installs  in docker container 
### Docker build -t name of docker conatiner you want to create it . (don't forget . at last)
### it created the new container in docker 