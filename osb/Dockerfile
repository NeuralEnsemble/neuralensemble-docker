#
# A Docker image for running neuronal models from Open Source Brain
#
# This image extends the basic "simulationx" image by adding support
# for libraries required for OSB models
#

# Use tagged version of neuralensemble/simulationx, e.g. Python 2, PyNN 0.9.1
#FROM neuralensemble/simulationx:py2_pynn094
# Temp for testing
FROM neuralensemble/simulationx_95
MAINTAINER p.gleeson@gmail.com

USER root

RUN apt-get update 
RUN apt-get install -y default-jdk python-tk python-lxml octave maven
RUN apt-get install -y htop libxml2-dev libxslt-dev zlib1g-dev
RUN apt-get install -y python3-setuptools unzip

RUN /bin/bash -c "source ~/env/neurosci/bin/activate"


# Install NeuroML Python libraries

RUN $VENV/bin/pip install git+https://github.com/NeuralEnsemble/libNeuroML.git@development
RUN $VENV/bin/pip install git+https://github.com/NeuroML/NeuroMLlite
RUN $VENV/bin/pip install git+https://github.com/NeuroML/pyNeuroML

###RUN $VENV/bin/pip install matplotlib==2.2.4

# Install OMV

RUN git clone https://github.com/OpenSourceBrain/osb-model-validation.git
RUN cd osb-model-validation && $VENV/bin/python setup.py install && cd -
RUN sed -i -e s/'\/usr\/bin\/python'/'\/home\/docker\/env\/neurosci\/bin\/python'/g $VENV/bin/omv


# Install jNeuroML, PyLEMS & NeuroML2

RUN $VENV/bin/omv install jNeuroML
ENV JNML_HOME=$HOME/jnml/jNeuroMLJar

RUN $VENV/bin/omv install jLEMS
ENV LEMS_HOME=$HOME/jLEMS

RUN $VENV/bin/omv install PyLEMS_NeuroML2

ENV PATH=$PATH:$JNML_HOME:$LEMS_HOME


# Set up NEURON (should be updated in neuralensemble/simulationx:py2...)

ENV PATH=$PATH:$HOME/env/neurosci/x86_64/bin
ENV NEURON_HOME=$HOME/env/neurosci/x86_64


# Set up NEST

ENV NEST_INSTALL_DIR=$HOME/env/neurosci


# Install NetPyNE

RUN apt-get remove -y python3-cycler python3-matplotlib python3-dateutil
RUN $VENV/bin/pip install matplotlib==2.2.4 pandas==0.23.4 python-dateutil==2.5.0
RUN $VENV/bin/pip install netpyne==0.9.5 

##RUN git clone https://github.com/Neurosim-lab/netpyne.git  && \
##    cd netpyne && \
##    git checkout neuroml_updates && \
##    python setup.py install && \
##    cd -


# Install GENESIS

RUN apt-get install -y bison flex unzip
RUN $VENV/bin/omv install genesis
ENV PATH=$PATH:$HOME/genesis/genesis2.4gamma-master/src


# Install OSB_API

RUN git clone https://github.com/OpenSourceBrain/OSB_API.git
RUN cd OSB_API/python && python setup.py install && cd -


# Install neuroConstruct

RUN git clone git://github.com/NeuralEnsemble/neuroConstruct.git
RUN cd neuroConstruct && ./updatenC.sh && ./nC.sh -make && cd -


# Install Moose

# Compile Moose with /usr/bin/python3, but install with venv version...
# Caused by (not insurmountable) issue finding python headers in venv
RUN git clone https://github.com/pgleeson/moose-core.git && cd moose-core && \
    mkdir build_ && cd build_ && cmake -DPYTHON_EXECUTABLE:FILEPATH=/usr/bin/python3 .. && \
    make -j4 && make install && cd python && $VENV/bin/python setup.py install


# Update PyNN

###USER docker
###RUN $VENV/bin/pip uninstall pynn -y

USER root
RUN git clone https://github.com/NeuralEnsemble/PyNN.git  && \
    cd  PyNN && \
    git checkout neuroml && \  
    $VENV/bin/python  setup.py install && \
    cd -   # neuroml branch has the latest NML2 import/export code!
RUN which python

# Update Brian

###RUN git clone https://github.com/brian-team/brian.git
###RUN cd brian && $HOME/env/neurosci/bin/python setup.py install && cd -


# Install Brian2

##RUN $HOME/env/neurosci/bin/pip install Brian2


# Get some latest Python packages

##RUN $HOME/env/neurosci/bin/pip install lazyarray --upgrade


# Some aliases

RUN echo '\n\nalias cd..="cd .."\nalias h=history\nalias ll="ls -alt"' >> ~/.bashrc

RUN echo "Built the main OSB Docker image!"



