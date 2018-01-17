FROM ubuntu:17.04

ENV CONDA_PREFIX /srv/conda
ENV PATH ${CONDA_PREFIX}/bin:$PATH

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

RUN install -d -o jovyan -g jovyan ${CONDA_PREFIX}

WORKDIR /home/jovyan

USER jovyan

RUN curl -o /tmp/miniconda.sh \
	https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86_64.sh 

# Install miniconda
RUN bash /tmp/miniconda.sh -b -u -p ${CONDA_PREFIX}

RUN conda config --set always_yes yes --set changeps1 no
RUN conda update -q conda

# Encapsulate the environment info into its own yml file (which carries
# the name `data100` in it
COPY environment.yml /tmp/
RUN conda env create -q -f /tmp/environment.yml

# We modify the path directly since the `source activate data100`
# environment won't be preserved here.
ENV PATH ${CONDA_PREFIX}/envs/data100/bin:$PATH

RUN pip install jupyterhub==0.8.1

RUN pip install nbgrader==0.5.4
RUN jupyter nbextension install --sys-prefix --py nbgrader
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader

RUN pip install jupyterlab==0.31.0rc1
RUN jupyter serverextension enable --sys-prefix --py jupyterlab

RUN pip install psycopg2==2.7.3.2

# Useful for debugging any issues with conda
RUN conda info -a

EXPOSE 8888
