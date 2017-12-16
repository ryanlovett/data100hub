FROM ubuntu:17.04

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV CONDA_DIR /srv/conda

RUN echo "${LC_ALL} UTF-8" > /etc/locale.gen && \
    locale-gen

RUN adduser --disabled-password --gecos "Default Jupyter user" jovyan

RUN install -d -o jovyan -g jovyan ${CONDA_DIR}

WORKDIR /home/jovyan

USER jovyan

CMD curl -o ${CONDA_DIR}/miniconda.sh \
	https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86_64.sh 

# This is set to be in $HOME, not container storage.
# Detritus could collect over time. 
CMD bash ${CONDA_DIR}/miniconda.sh -b -p ${CONDA_DIR}

ENV PATH ${CONDA_DIR}/bin:$PATH

CMD conda config --set always_yes yes --set changeps1 no
CMD conda update -q conda

# Useful for debugging any issues with conda
CMD conda info -a

# Encapsulate the environment info into its own yml file (which carries
# the name `data100` in it
ADD environment.yml ${CONDA_DIR}
CMD conda env create -q -f ${CONDA_DIR}/environment.yml
CMD source activate data100

ADD ipython_config.py ${CONDA_DIR}/etc/ipython/ipython_config.py

EXPOSE 8888
