
# ACR Build Commodore Cloud

This application is for use in demonstrating scenarios for Azure Container Registry Tasks. [ACR Tasks](https://docs.microsoft.com/azure/container-registry/container-registry-tasks-overview) is a suite of features within [Azure Container Registry](https://azure.microsoft.com/services/container-registry/) for performing Docker container builds on [Azure](https://azure.com), as well as automated OS and framework patching for Docker containers.

## Features

This project includes the following Dockerfiles:

* *Dockerfile* - Non-parameterized Dockerfile for building the application. References a base image in Docker Hub.
* *Dockerfile-app* - Parameterized, accepts the `REGISTRY_NAME` argument to specify the FQDN of the container registry from which the base image is pulled.
* *Dockerfile-base* - Defines a base image for the application defined in *Dockerfile-app*.

This project also includes the following YAML files:

* *taskmulti.yaml* - Specifies a multistep task to build, run, and push a container image specified by *Dockerfile*.
* *taskmulti-multiregistry.yaml* - Specifies a multistep task to build, run, and push container images specified by *Dockerfile* to multiple registries.

## Getting Started

### Companion articles

This project is intended for use with the following articles on [docs.microsoft.com][docs]:

* [Build container images in the cloud with Azure Container Registry Tasks][build-quick]
* [Automate container image builds in the cloud when you commit source code][build-task]
* [Run a multi-step container workflow in the cloud when you commit source code][multi-step]
* [Automate container image builds when a base image is updated in an Azure container registry][build-base]

### Quickstart

Although intended for use with the companion articles, you can perform the following steps to run the sample application. These steps require a local [Docker](http://docker.com) installation.

1. `git clone https://github.com/awhitney42/commodore-cloud`
1. `cd commodore-cloud`
1. `sudo docker build -t commodorecloud:v1 .`
1. `sudo docker run -d -p 2222:2222 -p 5900:5900 commodorecloud:v1`
1. `ssh -p 2222 vice@0.0.0.0` to access a shell within container
1. Connect using VNC to 0.0.0.0 to access VICE within the container


## Resources

[Blog Post with Full Instructions](https://adamwhitney.net/commodore-in-the-cloud-part-1/)

[Azure Container Registry](https://azure.microsoft.com/services/container-registry/)

[Azure Container Registry documentation](https://docs.microsoft.com/azure/container-registry/)

<!-- LINKS - External -->
[build-quick]: https://docs.microsoft.com/azure/container-registry/container-registry-tutorial-quick-build
[build-task]: https://docs.microsoft.com/azure/container-registry/container-registry-tutorial-build-task
[build-base]: https://docs.microsoft.com/azure/container-registry/container-registry-tutorial-base-image-update
[multi-step]: https://docs.microsoft.com/azure/container-registry/container-registry-tutorial-multistep-task
[docs]: http://docs.microsoft.com
