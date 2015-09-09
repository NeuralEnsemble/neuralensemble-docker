#
# A base Docker image for Python-based computational neuroscience and neurophysiology
#

FROM neurodebian:jessie
MAINTAINER andrew.davison@unic.cnrs-gif.fr

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

ENV LANG=C.UTF-8

RUN apt-get install -y automake libtool build-essential openmpi-bin libopenmpi-dev git vim  \
                       wget python libpython-dev libncurses5-dev libreadline-dev libgsl0-dev cython \
                       python-pip python-numpy python-scipy python-matplotlib python-jinja2 python-mock \
                       python-virtualenv ipython python-httplib2 python-docutils python-yaml \
                       subversion python-mpi4py
RUN apt-get install -y python-tables

RUN useradd -ms /bin/bash docker
USER docker
ENV HOME=/home/docker
RUN mkdir $HOME/env; mkdir $HOME/packages

ENV VENV=$HOME/env/neurosci

RUN virtualenv --system-site-packages $VENV

RUN $VENV/bin/pip install parameters quantities neo django django-tagging future hgapi gitpython sumatra
RUN $VENV/bin/pip install --upgrade nose ipython
