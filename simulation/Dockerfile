#
# A Docker image for running neuronal network simulations
#

FROM neuralensemble/base:py2
MAINTAINER andrew.davison@unic.cnrs-gif.fr

ENV NEST_VER=2.16.0 NRN_VER=7.5
ENV NEST=nest-simulator-$NEST_VER NRN=nrn-$NRN_VER

WORKDIR $HOME/packages
RUN wget https://github.com/nest/nest-simulator/archive/v$NEST_VER.tar.gz -O $HOME/packages/$NEST.tar.gz;
RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v$NRN_VER/$NRN.tar.gz
RUN tar xzf $NEST.tar.gz; tar xzf $NRN.tar.gz; rm $NEST.tar.gz $NRN.tar.gz
RUN git clone --depth 1 https://github.com/INCF/libneurosim.git
RUN cd libneurosim; ./autogen.sh

RUN mkdir $VENV/build
WORKDIR $VENV/build
RUN mkdir libneurosim; \
    cd libneurosim; \
    PYTHON=$VENV/bin/python $HOME/packages/libneurosim/configure --prefix=$VENV; \
    make; make install; ls $VENV/lib $VENV/include
RUN ln -s /usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.so $VENV/lib/
RUN mkdir $NEST; \
    cd $NEST; \
    cmake -DCMAKE_INSTALL_PREFIX=$VENV \
          -Dwith-mpi=ON  \
          ###-Dwith-music=ON \
          -Dwith-libneurosim=ON \
          -DPYTHON_LIBRARY=$VENV/lib/libpython2.7.so \
          -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 \
          $HOME/packages/$NEST; \
    make; make install
RUN mkdir $NRN; \
    cd $NRN; \
    $HOME/packages/$NRN/configure --with-paranrn --with-nrnpython=$VENV/bin/python --disable-rx3d --without-iv --prefix=$VENV; \
    make; make install; \
    cd src/nrnpython; $VENV/bin/python setup.py install; \
    cd $VENV/bin; ln -s ../x86_64/bin/nrnivmodl

RUN PATH=$PATH:$VENV/bin $VENV/bin/pip install lazyarray brian nrnutils PyNN

WORKDIR /home/docker/
RUN echo "source $VENV/bin/activate" >> .bashrc
