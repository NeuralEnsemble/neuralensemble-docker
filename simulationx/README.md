# Biological neuronal network simulations with Python


## What it gives you

* shell environment with NEST 2.6, NEURON 7.3, Brian 1.4 and PyNN 0.8 installed.
* IPython, scipy, matplotlib and OpenMPI are also installed.
* ssh access, so you can access the container with multiple terminals.
* X-windows support, so you can display windows running in the container on your host display.
* use directly or as a base for your own project-specific Docker images.


## Setup

To enable ssh access you will need to obtain the private key for the image. Start a container with a bash shell:

```
(host)$ docker run -i -t neuralensemble/simulation /bin/bash
```

and then in the container run:

```
(docker)# cat $KEYFILE
```

Copy-and-paste the output into a file in your working directory, e.g. `docker_key` and then set the
access permissions so only you can read it, i.e. `chmod go-r docker_key`.

(Note: since anyone can obtain this key by downloading the image, it is not safe for running on the public web,
and is intended only for running locally. If you wish to run this image in the cloud, you should create a new
key pair).


## Basic use

In normal use, you will run the container as an SSH server:

```
(host)$ docker run -d -p 22
```

Run `docker ps` to obtain the port number, and then use this to connect to the container:

```
(host)$ ssh -Y -i ./docker_key -p 32782 docker@localhost
```

You should then activate the "simulation" virtual environment:

```
(docker)$ source ~/env/simulation/bin/activate
```

after which you can run simulations with Python and MPI. To test that X11 forwarding is working, run `xeyes`.


## Mac OS X

On Mac OS X, you will need to launch XQuartz if you want to display X11 windows.
 
Since you will be running Docker in a VM, e.g. using `boot2docker` or `docker-machine`, 
you will need to obtain the IP address of the VM, e.g.

```
(host)$ docker-machine ip default
192.168.99.100
(host)$ ssh -Y -i ./docker_key -p 32782 docker@192.168.99.100
```

## Documentation

For documentation of the simulation tools installed in the image, see http://neuralensemble.org/projects/
