#
# A Docker image for running neuronal network simulations
#

FROM neuralensemble/base
MAINTAINER andrew.davison@unic.cnrs-gif.fr

ENV NEST_VER=2.6.0
ENV NEST=nest-$NEST_VER NRN=nrn-7.3

WORKDIR /home/docker/packages
RUN wget https://github.com/nest/nest-simulator/releases/download/v$NEST_VER/$NEST.tar.gz
RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.3/$NRN.tar.gz
RUN tar xzf $NEST.tar.gz; tar xzf $NRN.tar.gz; rm $NEST.tar.gz $NRN.tar.gz
RUN svn co --username Anonymous --password Anonymous --non-interactive http://svn.incf.org/svn/libneurosim/trunk libneurosim
RUN cd libneurosim; ./autogen.sh

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

RUN $VENV/bin/pip install lazyarray brian nrnutils
RUN wget https://github.com/NeuralEnsemble/PyNN/archive/0.8.0rc1.tar.gz -O /home/docker/packages/PyNN-0.8.0rc1.tar.gz
RUN PATH=$PATH:$VENV/bin $VENV/bin/pip install /home/docker/packages/PyNN-0.8.0rc1.tar.gz

WORKDIR /home/docker/
