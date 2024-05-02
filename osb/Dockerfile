#
# A Docker image for running neuronal models from Open Source Brain
#
# This image extends the basic "simulationx" image by adding support
# for libraries required for OSB models
#

# Use tagged version of neuralensemble/simulationx, e.g. Python 2, PyNN 0.9.1
#FROM neuralensemble/simulationx:py2_pynn094
# For local testing
FROM neuralensemble/simulationx
MAINTAINER p.gleeson@gmail.com

USER root

RUN apt-get update
RUN apt-get install -y default-jdk python-tk python-lxml octave maven
RUN apt-get install -y htop libxml2-dev libxslt-dev zlib1g-dev
RUN apt-get install -y python3-setuptools unzip

RUN /bin/bash -c "source ~/env/neurosci/bin/activate"

#### Set versions

# This will set the versions of simulators installed with 'omv install ...'
ENV OMV_VER=v0.2.13

ENV PYNEUROML_VER=1.1.1
ENV NETPYNE_VER=1.0.5
ENV EDEN_VER=0.2.2


# Install NeuroML Python libraries

RUN $VENV/bin/pip install pyNeuroML==$PYNEUROML_VER # will set versions of libNeuroML, pylems, NeuroMLlite...


# Install OMV

RUN $VENV/bin/pip install git+https://github.com/OpenSourceBrain/osb-model-validation@${OMV_VER}
RUN sed -i -e s/'\/usr\/bin\/python'/'\/home\/docker\/env\/neurosci\/bin\/python'/g $VENV/bin/omv


# Install jNeuroML, PyLEMS & NeuroML2

RUN $VENV/bin/omv install jNeuroML  
ENV JNML_HOME=$HOME/jnml/jNeuroMLJar

RUN $VENV/bin/omv install jLEMS
ENV LEMS_HOME=$HOME/jLEMS

RUN $VENV/bin/omv install PyLEMS_NeuroML2

ENV PATH=$PATH:$JNML_HOME:$LEMS_HOME


# Set up NEURON (TODO: should be set in neuralensemble/simulationx...)

ENV PATH=$PATH:$HOME/env/neurosci/bin
ENV NEURON_HOME=$HOME/env/neurosci


# Set up NEST

ENV NEST_INSTALL_DIR=$HOME/env/neurosci


# Install NetPyNE

RUN apt-get remove -y python3-cycler python3-matplotlib python3-dateutil
RUN $VENV/bin/pip install netpyne==$NETPYNE_VER


######### Disabled for now, issues compiling on bionic....
# Install GENESIS

#RUN apt-get install -y bison flex unzip
#RUN $VENV/bin/omv install genesis
#ENV PATH=$PATH:$HOME/genesis/genesis2.4gamma-master/src


# Install OSB_API

RUN git clone https://github.com/OpenSourceBrain/OSB_API.git
RUN cd OSB_API/python && python setup.py install && cd -


# Install neuroConstruct

RUN git clone https://github.com/NeuralEnsemble/neuroConstruct.git
RUN cd neuroConstruct && ./updatenC.sh && ./nC.sh -make && cd -


# Install Moose

RUN omv install moose

# Install Arbor

RUN omv install arbor

# Install EDEN

RUN $VENV/bin/pip install eden-simulator==$EDEN_VER


USER root

RUN which python

RUN $VENV/bin/pip install 'numpy<=1.23.0' # see https://github.com/OpenSourceBrain/osb-model-validation/issues/91

# Some aliases

RUN echo '\n\nalias cd..="cd .."\nalias h=history\nalias ll="ls -alt"' >> ~/.bashrc

RUN $VENV/bin/omv list -V
RUN echo "Built the main OSB Docker image!"
