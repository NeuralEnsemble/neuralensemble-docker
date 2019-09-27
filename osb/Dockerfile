#
# A Docker image for running neuronal models from Open Source Brain
#
# This image extends the basic "simulationx" image by adding support
# for libraries required for OSB models
#

# Use tagged version of neuralensemble/simulationx, e.g. Python 2, PyNN 0.9.1
#FROM neuralensemble/simulationx:py2_pynn091
# Temp for testing
FROM neuralensemble/simulationx_newpy3
MAINTAINER p.gleeson@gmail.com

USER root

RUN apt-get update 
RUN apt-get install -y default-jdk python-tk python-lxml octave maven
RUN apt-get install -y htop libxml2-dev libxslt-dev zlib1g-dev

RUN /bin/bash -c "source ~/env/neurosci/bin/activate"


# Install NeuroML Python libraries

RUN pip install git+https://github.com/NeuralEnsemble/libNeuroML.git@development
RUN pip install git+https://github.com/NeuroML/pyNeuroML


# Install OMV

RUN git clone https://github.com/OpenSourceBrain/osb-model-validation.git
RUN cd osb-model-validation && python setup.py install && cd -
RUN sed -i -e s/'\/usr\/bin\/python'/'\/home\/docker\/env\/neurosci\/bin\/python'/g /usr/local/bin/omv


# Install jNeuroML, PyLEMS & NeuroML2

RUN omv install jNeuroML
ENV JNML_HOME=$HOME/jnml/jNeuroMLJar

RUN omv install jLEMS
ENV LEMS_HOME=$HOME/jLEMS

RUN omv install PyLEMS_NeuroML2

ENV PATH=$PATH:$JNML_HOME:$LEMS_HOME


# Set up NEURON (should be updated in neuralensemble/simulationx:py2...)

ENV PATH=$PATH:$HOME/env/neurosci/x86_64/bin
ENV NEURON_HOME=$HOME/env/neurosci/x86_64


# Set up NEST

ENV NEST_INSTALL_DIR=$HOME/env/neurosci


# Install NetPyNE

RUN $HOME/env/neurosci/bin/pip install pandas==0.23.4 matplotlib==2.2.4
RUN git clone https://github.com/Neurosim-lab/netpyne.git  && \
    cd netpyne && \
    git checkout neuroml_updates && \
    $HOME/env/neurosci/bin/python setup.py install && \
    cd -


# Install GENESIS

RUN apt-get install -y bison flex unzip
RUN omv install genesis
ENV PATH=$PATH:$HOME/genesis/genesis2.4gamma-master/src


# Install OSB_API

RUN git clone https://github.com/OpenSourceBrain/OSB_API.git
RUN cd OSB_API/python && python setup.py install && cd -


# Install neuroConstruct

RUN git clone git://github.com/NeuralEnsemble/neuroConstruct.git
RUN cd neuroConstruct && ./updatenC.sh && ./nC.sh -make && cd -


# Install Moose

RUN omv install Moose


# Update PyNN

USER docker
RUN $HOME/env/neurosci/bin/pip uninstall pynn -y

USER root
RUN git clone https://github.com/NeuralEnsemble/PyNN.git  && \
    cd  PyNN && \
    git checkout neuroml && \  
    $HOME/env/neurosci/bin/python  setup.py install && \
    cd -   # neuroml branch has the latest NML2 import/export code!
RUN which python

# Update Brian

RUN git clone https://github.com/brian-team/brian.git
RUN cd brian && $HOME/env/neurosci/bin/python setup.py install && cd -


# Install Brian2

RUN $HOME/env/neurosci/bin/pip install Brian2


# Get some latest Python packages

RUN $HOME/env/neurosci/bin/pip install lazyarray --upgrade


# Some aliases

RUN echo '\n\nalias cd..="cd .."\nalias h=history\nalias ll="ls -alt"' >> ~/.bashrc

RUN echo "Built the main OSB Docker image!"



