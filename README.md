# vagrant-docker-provider-alpine-latest

Alpine-based Docker image to use as a Vagrant docker provider — same behavior as
`vagrant-docker-provider-ubuntu-latest` but using Alpine for faster builds.

To use:
1. Install docker.
2. Install vagrant.
3. Save a Vagrantfile that references this image. Use the example in this repo. Then "vagrant up" to start an environment.

To build the image locally:
1. `docker build -t vagrant-docker-provider-alpine-latest .`
