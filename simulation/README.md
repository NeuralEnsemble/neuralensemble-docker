# Biological neuronal network simulations with Python

## What it gives you

* shell environment with NEST 2.6, NEURON 7.3, Brian 1.4 and PyNN 0.8 installed.
* IPython, scipy, matplotlib and OpenMPI are also installed.
* use directly or as a base for your own project-specific Docker images.

## Basic use

The following command starts a container with the bash shell, running as user `docker`.

```
docker run -i -t neuralensemble/simulation /bin/bash
```

You should then activate the "simulation" virtual environment:

```
source ~/env/simulation/bin/activate
```

after which you can run simulations with Python and MPI.

Note that this image does not provide an X11 graphical environment, so GUI tools will not work;
use the `neuralensemble/simulationx` image if you need X11.

## Documentation

For documentation of the simulation tools installed in the image, see http://neuralensemble.org/projects/
