#
# A Docker image for running neuronal network simulations
#

FROM neurodebian:jessie
MAINTAINER andrew.davison@unic.cnrs-gif.fr

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
#RUN locale -a
#RUN apt-get install -y language-pack-en
#RUN locale-gen en_US.UTF-8 && \
#    dpkg-reconfigure locales && \
#    /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LANG=C.UTF-8

RUN apt-get install -y automake libtool build-essential openmpi-bin libopenmpi-dev git vim  \
                       wget python libpython-dev libncurses5-dev libreadline-dev libgsl0-dev cython \
                       python-pip python-numpy python-scipy python-matplotlib python-jinja2 python-mock \
                       python-virtualenv python-sympy ipython
RUN apt-get install -y subversion python-mpi4py

RUN useradd -ms /bin/bash docker
USER docker
ENV HOME=/home/docker
RUN mkdir $HOME/env; mkdir $HOME/packages

ENV VENV=$HOME/env/simulation NEST=nest-2.6.0 NRN=nrn-7.3

WORKDIR /home/docker/packages
RUN wget http://www.nest-simulator.org/downloads/gplreleases/$NEST.tar.gz
RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.3/$NRN.tar.gz
RUN tar xzf $NEST.tar.gz; tar xzf $NRN.tar.gz; rm $NEST.tar.gz $NRN.tar.gz
RUN svn co --username Anonymous --password Anonymous --non-interactive http://svn.incf.org/svn/libneurosim/trunk libneurosim
RUN cd libneurosim; ./autogen.sh

RUN virtualenv --system-site-packages $VENV

RUN mkdir $VENV/build
WORKDIR $VENV/build
RUN mkdir libneurosim; \
    cd libneurosim; \
    PYTHON=$VENV/bin/python $HOME/packages/libneurosim/configure --prefix=$VENV; \
    make; make install; ls $VENV/lib $VENV/include
RUN mkdir $NEST; \
    cd $NEST; \
    PYTHON=$VENV/bin/python $HOME/packages/$NEST/configure --with-mpi --prefix=$VENV --with-libneurosim=$VENV; \
    make; make install
RUN mkdir $NRN; \
    cd $NRN; \
    $HOME/packages/$NRN/configure --with-paranrn --with-nrnpython=$VENV/bin/python --without-iv --prefix=$VENV; \
    make; make install; \
    cd src/nrnpython; $VENV/bin/python setup.py install; \
    cd $VENV/bin; ln -s ../x86_64/bin/nrnivmodl

RUN $VENV/bin/pip install lazyarray parameters quantities neo brian nrnutils
RUN $VENV/bin/pip install --upgrade nose ipython
RUN PATH=$PATH:$VENV/bin $VENV/bin/pip install https://github.com/NeuralEnsemble/PyNN/archive/0.8.0rc1.zip

WORKDIR /home/docker/
