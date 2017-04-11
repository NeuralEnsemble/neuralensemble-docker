# Biological neuronal network simulations with Python


## What it gives you

* shell environment with NEST 2.12, NEURON 7.4, and PyNN 0.9 installed.
* The Python 2.7 version provides Brian 1.4, the Python 3.4 version provides Brian 2.
* IPython, scipy, matplotlib and OpenMPI are also installed.
* ssh access, so you can access the container with multiple terminals.
* X-windows support, so you can display windows running in the container on your host display.
* use directly or as a base for your own project-specific Docker images.


## Setup

To enable ssh access you will need to obtain the private key for the image. First run the following command:

```
(host)$ docker run -i -t neuralensemble/simulationx /bin/cat /home/docker/.ssh/id_rsa > docker_key
```

Now set the access permissions on the key file so only you can read it, i.e. `chmod go-r docker_key`.

(Note: since anyone can obtain this key by downloading the image, it is not safe for running on the public web,
and is intended only for running locally. If you wish to run this image in the cloud, you should create a new
key pair).


## Basic use

In normal use, you will run the container as an SSH server:

```
(host)$ docker run -d -p 22 neuralensemble/simulationx
```

Run `docker ps` to obtain the port number, and then use this to connect to the container:

```
(host)$ ssh -Y -i ./docker_key -p 32782 docker@localhost
```

On connection, you should already be in the "neurosci" virtual environment. If not, run

```
(docker)$ source ~/env/neurosci/bin/activate
```

after which you can run simulations with Python and MPI. To test that X11 forwarding is working, run `xeyes`.


## Mac OS X

On Mac OS X, you will need to launch XQuartz if you want to display X11 windows.
 
If using `boot2docker` or `docker-machine`, you will need to obtain the IP address of the VM, e.g.

```
(host)$ docker-machine ip default
192.168.99.100
(host)$ ssh -Y -i ./docker_key -p 32782 docker@192.168.99.100
```

## Documentation

For documentation of the simulation tools installed in the image, see http://neuralensemble.org/projects/
