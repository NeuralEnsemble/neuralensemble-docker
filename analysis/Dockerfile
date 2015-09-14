#
# A Docker image for neuroscience data analysis with Python
#


FROM neuralensemble/base
MAINTAINER andrew.davison@unic.cnrs-gif.fr

# uninstall stable Neo, install development version
RUN $VENV/bin/pip uninstall -y neo
RUN wget https://github.com/NeuralEnsemble/python-neo/archive/apibreak.tar.gz -O /home/docker/packages/neo_apibreak.tar.gz
RUN PATH=$PATH:$VENV/bin $VENV/bin/pip install /home/docker/packages/neo_apibreak.tar.gz
#RUN $VENV/bin/pip install git+https://github.com/NeuralEnsemble/python-neo.git@apibreak#egg=neo-apibreak
RUN $VENV/bin/pip install elephant

# in analysisX, add SpykeViewer, OpenElectrophy, KlustaSuite

WORKDIR /home/docker/
