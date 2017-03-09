# Biological neuronal network simulations with Python

## What it gives you

* shell environment with NEST 2.12, NEURON 7.4, and PyNN 0.8 installed.
* The Python 2.7 version provides Brian 1.4, the Python 3.4 version provides Brian 2.
* IPython, scipy, matplotlib and OpenMPI are also installed.
* use directly or as a base for your own project-specific Docker images.

## Basic use

The following command starts a container with the bash shell, running as user `docker`,
in a Python virtual environment named "neurosci"

```
docker run -i -t neuralensemble/simulation /bin/bash
```

after which you can run simulations with Python and MPI.

Note that this image does not provide an X11 graphical environment, so GUI tools will not work;
use the `neuralensemble/simulationx` image if you need X11.

## Documentation

For documentation of the simulation tools installed in the image, see http://neuralensemble.org/projects/
