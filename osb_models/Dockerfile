#
# A Docker image containing a number of core models from Open Source Brain
#
# This image extends the basic "simulationx" image by adding support
# for libraries required for OSB models
#

# Version from Dockerhub
#FROM opensourcebrain/simulation:osb-v0.8.4

# Local build
FROM neuralensemble/osb                                  

MAINTAINER p.gleeson@gmail.com

USER root

RUN git clone https://github.com/OpenSourceBrain/osb-model-validation.git

# Clone core set of models

RUN osb-model-validation/utilities/getcoreosbprojects.sh

# Pre-compile mod files for some models

RUN cd coreprojects/SmithEtAl2013-L23DendriticSpikes/NEURON/test && nrnivmodl ../mod.files

RUN cd coreprojects/L5bPyrCellHayEtAl2011/NEURON/test && nrnivmodl ../mod

RUN cd coreprojects/ca1/NeuroML2 && nrnivmodl .. 

RUN cd coreprojects/SadehEtAl2017-InhibitionStabilizedNetworks && ./make_tests.sh

RUN cd coreprojects/PotjansDiesmann2014/ && ./make_tests.sh

# For Allen
RUN $VENV/bin/pip install allensdk
RUN cd coreprojects/AllenInstituteNeuroML/CellTypesDatabase/models/ && python download.py


RUN echo "Built OSB models Docker image!"



