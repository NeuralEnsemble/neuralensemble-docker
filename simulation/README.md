# Biological neuronal network simulations with Python

## What it gives you

* shell environment with NEST, NEURON, Brian and PyNN installed (for specific versions see [Dockerfile](Dockerfile)).
* The Python 2 version provides Brian 1.4, the Python 3 version provides Brian 2.
* IPython, scipy, matplotlib and OpenMPI are also installed.
* use directly or as a base for your own project-specific Docker images.

## Basic use

The following command starts a container with the bash shell, running as user `docker`,
in a Python virtual environment named "neurosci"

```
docker run -i -t neuralensemble/simulation /bin/bash
```

after which you can run simulations with Python and MPI. This will use **Python 3.5** as the Python version; if you'd prefer **Python 2.7** use:

```
docker run -i -t neuralensemble/simulation:py2 /bin/bash
```

Note that this image does not provide an X11 graphical environment, so GUI tools will not work;
use the `neuralensemble/simulationx` image if you need X11.

## Docker Hub

More information on the various images which have been released can be found at: https://hub.docker.com/r/neuralensemble/

## Documentation for simulators

For documentation of the simulation tools installed in the image, see http://neuralensemble.org/projects/
