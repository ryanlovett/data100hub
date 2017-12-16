FROM ubuntu:17.04

ENV CONDA_DIR /srv/conda
ENV PATH ${CONDA_DIR}/bin:$PATH

RUN apt-get update && \
	apt-get install --yes \
		locales \
		python3.6 \
		python3.6-dev \
		build-essential \
		tar \
		git \
		curl \
		wget \
		vim \
		# for nbconvert
		pandoc \
		texlive-xetex \
		texlive-fonts-recommended \
		texlive-generic-recommended \
		;

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN echo "${LC_ALL} UTF-8" > /etc/locale.gen && \
	locale-gen

RUN adduser --disabled-password --gecos "Default Jupyter user" jovyan

RUN install -d -o jovyan -g jovyan ${CONDA_DIR}

WORKDIR /home/jovyan

USER jovyan

RUN curl -o /tmp/miniconda.sh \
	https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86_64.sh 

# This is set to be in $HOME, not container storage.
# Detritus could collect over time. 
RUN bash /tmp/miniconda.sh -b -u -p ${CONDA_DIR}

RUN conda config --set always_yes yes --set changeps1 no
RUN conda update -q conda

# Useful for debugging any issues with conda
RUN conda info -a

# Encapsulate the environment info into its own yml file (which carries
# the name `data100` in it
COPY environment.yml /tmp/
RUN conda env create -q -f /tmp/environment.yml
RUN [ "/bin/bash", "-c", "source activate data100"]

ADD ipython_config.py ${CONDA_DIR}/etc/ipython/ipython_config.py

EXPOSE 8888
