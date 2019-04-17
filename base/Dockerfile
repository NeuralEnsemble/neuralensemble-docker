#
# A base Docker image for Python-based computational neuroscience and neurophysiology
#

FROM neurodebian:xenial
MAINTAINER andrew.davison@unic.cnrs-gif.fr

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8

RUN apt-get update; apt-get install -y automake libtool build-essential openmpi-bin libopenmpi-dev git vim  \
                       wget python libpython-dev libncurses5-dev libreadline-dev libgsl0-dev cython \
                       python-pip python-numpy python-scipy python-matplotlib python-jinja2 python-mock \
                       python-virtualenv ipython python-httplib2 python-docutils python-yaml \
                       subversion python-mpi4py python-tables python-h5py cmake zlib1g-dev

RUN useradd -ms /bin/bash docker
USER docker
ENV HOME=/home/docker
RUN mkdir $HOME/env; mkdir $HOME/packages

ENV VENV=$HOME/env/neurosci

RUN virtualenv --system-site-packages $VENV

RUN $VENV/bin/pip install --upgrade pip
RUN $VENV/bin/pip install parameters quantities neo==0.5.1 "django<1.9" django-tagging future hgapi gitpython sumatra nixio
RUN $VENV/bin/pip install --upgrade nose ipython
