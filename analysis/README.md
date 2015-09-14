# Neuroscience data analysis with Python

## What it gives you

* shell environment with Neo (development version) and Elephant installed.
* IPython, scipy, matplotlib and OpenMPI are also installed.
* use directly or as a base for your own project-specific Docker images.

More analysis tools will be added in future releases, coming soon!

## Basic use

The following command starts a container with the bash shell, running as user `docker`.

```
docker run -i -t neuralensemble/analysis /bin/bash
```

You should then activate the "neurosci" virtual environment:

```
source ~/env/neurosci/bin/activate
```

after which you can run ....

Note that this image does not provide an X11 graphical environment, so GUI tools will not work;
use the `neuralensemble/analysisx` image if you need X11.

## Documentation

For documentation of the tools installed in the image, see http://neuralensemble.org/projects/
