# Docker file to run StyleGAN3 + CLIP, docker-stylegan3-clip
* Licensed under the MIT license
rtwomey@unl.edu 2024

---

Adapted from [Jeff Heaton's](http://www.heatonresearch.com) Docker image for running Stylegan3 with GPU. 
* GitHub: https://github.com/jeffheaton/docker-stylegan3
* DockerHub: https://hub.docker.com/r/heatonresearch/stylegan3

This dockerfile is intended to be run from Docker. To start a container from this image run something similar to the following:

```bash
sudo docker run -it --gpus all -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $(pwd)/work:/content/mnt gitlab-registry.nrp-nautilus.io/rtwomey/docker-stylegan3-clip
```

# Docker Workflow

## push to Nautilus gitlab

```bash
git remote add nautilus https://gitlab.nrp-nautilus.io/rtwomey/docker-stylegan3-clip
git push nautilus
```
 
## push docker image to nautilus gitlab container registry

login to gitlab
```bash
docker login gitlab-registry.nrp-nautilus.io -u rtwomey
```

build and push to gitlab container registry
```bash
docker build -t gitlab-registry.nrp-nautilus.io/rtwomey/docker-stylegan3-clip .
docker push gitlab-registry.nrp-nautilus.io/rtwomey/docker-stylegan3-clip
```


In the gitlab repo, select **Deploy -> Container Registry** 

![[Pasted image 20240318060733.png]]

## Run docker image

launch docker: 
```bash
sudo docker run -it --gpus all -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $(pwd)/work:/content/mnt gitlab-registry.nrp-nautilus.io/rtwomey/docker-stylegan3-clip
```

port forwarding (run on local macbook air):
```bash
ssh -N -L localhost:8888:localhost:8888 user@z8.local
```

start script **start-sg3.sh** (run from z8 home directory):
```bash
#!/bin/bash
docker run -it --gpus all -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $(pwd)/work:/content/mnt gitlab-registry.nrp-nautilus.io/rtwomey/docker-stylegan3-clip
```
