#
# A Docker image for running neuronal network simulations
#

FROM neuralensemble/base
MAINTAINER andrew.davison@unic.cnrs-gif.fr

RUN ln -s /usr/bin/2to3-3.5 $VENV/bin/2to3


#### Set versions

ENV NEST_VER=3.3
ENV NRN_VER=8.1.0
ENV BRIAN2_VER=2.5.1
ENV PYNN_VER=0.10.1


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
    ln -s /usr/lib/python3.8/config-3.8-x86_64-linux-gnu/libpython3.8.so $VENV/lib/; \
    cmake -DCMAKE_INSTALL_PREFIX=$VENV \
          -Dwith-mpi=ON  \
          ###-Dwith-music=ON \
          -Dwith-libneurosim=ON \
          -DPYTHON_EXECUTABLE:FILEPATH=$VENV/bin/python \
          -DPYTHON_LIBRARY=$VENV/lib/libpython3.8.so \
          -DPYTHON_INCLUDE_DIR=/usr/include/python3.8 \
          $HOME/packages/$NEST; \
    make -j7; make install


#### Install NEURON

RUN $VENV/bin/pip install neuron==$NRN_VER


#### Install Brian2

# Note: Brian 1.4.1 not Python 3 compatible
RUN $VENV/bin/pip install brian2==$BRIAN2_VER


#### Set paths

ENV PATH=$PATH:$VENV/bin


#### Install PyNN

RUN $VENV/bin/pip install PyNN==$PYNN_VER
RUN cd /home/docker/env/neurosci/lib/python3.8/site-packages/pyNN/neuron/nmodl; nrnivmodl; cd -


#### Activate Python environment

WORKDIR /home/docker/

RUN echo "source $VENV/bin/activate" >> .bashrc
