#
# A Docker image for running neuronal network simulations
#

FROM neuralensemble/base:bullseye-arm64
MAINTAINER andrew.davison@cnrs.fr

#### Set versions

ENV NEST_VER=3.4
ENV NRN_VER=8.1
# Note: see below re Brian2 support...
ENV BRIAN2_VER=2.5.1
ENV PYNN_VER=0.11.0


#### Install NEST

ENV NEST=nest-simulator-$NEST_VER

WORKDIR $HOME/packages
RUN wget https://github.com/nest/nest-simulator/archive/v$NEST_VER.tar.gz -O $HOME/packages/$NEST.tar.gz;
RUN tar xzf $NEST.tar.gz; rm $NEST.tar.gz
RUN git clone https://github.com/INCF/libneurosim.git
RUN cd libneurosim; git checkout 6d1044f; ./autogen.sh

RUN mkdir $VENV/build
WORKDIR $VENV/build
RUN mkdir libneurosim; \
    cd libneurosim; \
    PYTHON=$VENV/bin/python $HOME/packages/libneurosim/configure --prefix=$VENV; \
    make; make install; ls $VENV/lib $VENV/include
RUN mkdir $NEST; \
    cd $NEST; \
    ln -s /usr/lib/python3.9/config-3.9-aarch64-linux-gnu/libpython3.9.so $VENV/lib/; \
    cmake -DCMAKE_INSTALL_PREFIX=$VENV \
          -Dwith-mpi=ON  \
          ###-Dwith-music=ON \
          -Dwith-libneurosim=ON \
          -DPYTHON_EXECUTABLE:FILEPATH=$VENV/bin/python \
          -DPYTHON_LIBRARY=$VENV/lib/libpython3.9.so \
          -DPYTHON_INCLUDE_DIR=/usr/include/python3.9 \
          $HOME/packages/$NEST; \
    make -j7; make install


#### Install NEURON

RUN $VENV/bin/pip install neuron==$NRN_VER

#### Install Brian2

RUN $VENV/bin/pip install brian2==$BRIAN2_VER

#### Set paths

ENV PATH=$PATH:$VENV/bin

#### Install PyNN

RUN $VENV/bin/pip install PyNN==$PYNN_VER
#RUN $VENV/bin/pip install git+https://github.com/NeuralEnsemble/PyNN.git

#### Activate Python environment

WORKDIR /home/docker/

RUN echo "source $VENV/bin/activate" >> .bashrc
