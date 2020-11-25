#
# A Docker image for running neuronal network simulations
#

FROM neuralensemble/base_95
MAINTAINER andrew.davison@unic.cnrs-gif.fr

RUN ln -s /usr/bin/2to3-3.5 $VENV/bin/2to3


#### Set versions

ENV NEST_VER=2.18.0 
ENV NRN_VER=7.7
# Note: see below re Brian2 support...
ENV BRIAN2_VER=2.3   
ENV PYNN_VER=0.9.5


#### Install NEST

ENV NEST=nest-simulator-$NEST_VER

WORKDIR $HOME/packages
RUN wget https://github.com/nest/nest-simulator/archive/v$NEST_VER.tar.gz -O $HOME/packages/$NEST.tar.gz;
RUN tar xzf $NEST.tar.gz; rm $NEST.tar.gz
RUN git clone https://github.com/INCF/libneurosim.git
RUN cd libneurosim; git checkout 03646747c8fe64fa3439ac2d282623b659f60c22; ./autogen.sh

RUN mkdir $VENV/build
WORKDIR $VENV/build
RUN mkdir libneurosim; \
    cd libneurosim; \
    PYTHON=$VENV/bin/python $HOME/packages/libneurosim/configure --prefix=$VENV; \
    make; make install; ls $VENV/lib $VENV/include
RUN mkdir $NEST; \
    cd $NEST; \
    ln -s /usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/libpython3.5.so $VENV/lib/; \
    cmake -DCMAKE_INSTALL_PREFIX=$VENV \
          -Dwith-mpi=ON  \
          ###-Dwith-music=ON \
          -Dwith-libneurosim=ON \
          -DPYTHON_LIBRARY=$VENV/lib/libpython3.5.so \
          -DPYTHON_INCLUDE_DIR=/usr/include/python3.5 \
          $HOME/packages/$NEST; \
    make; make install


#### Install NEURON

ENV NRN=nrn-$NRN_VER

WORKDIR $HOME/packages
RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v$NRN_VER/$NRN.tar.gz
RUN tar xzf $NRN.tar.gz; rm $NRN.tar.gz

RUN mkdir $NRN; \
    cd $NRN; \
    $HOME/packages/$NRN/configure --with-paranrn --with-nrnpython=$VENV/bin/python --disable-rx3d --without-iv --prefix=$VENV; \
    make; make install; \
    cd src/nrnpython; $VENV/bin/python setup.py install; \
    cd $VENV/bin; ln -s ../x86_64/bin/nrnivmodl

RUN $VENV/bin/pip install nrnutils==0.2.0


#### Install Brian2  

# Note 1: Brian 1.4.1 not Python 3 compatible
# Note 2: For latest status on Brian 2 support in PyNN see: https://github.com/NeuralEnsemble/PyNN/pull/654

RUN $VENV/bin/pip install brian2==$BRIAN2_VER


#### Install PyNN

RUN $VENV/bin/pip install lazyarray==0.3.3 PyNN==$PYNN_VER


#### Set paths and activate Python environment

RUN PATH=$PATH:$VENV/bin 

WORKDIR /home/docker/
RUN echo "source $VENV/bin/activate" >> .bashrc
