# Docker file to run StyleGAN3 + CLIP, docker-stylegan3-clip
* Licensed under the MIT license
rtwomey@unl.edu 2024

---

Adapted from [Jeff Heaton's](http://www.heatonresearch.com) Docker image for running Stylegan3 with GPU. 
* GitHub: https://github.com/jeffheaton/docker-stylegan3
* DockerHub: https://hub.docker.com/r/heatonresearch/stylegan3

This dockerfile is intended to be run from Docker. To start a container from this image run something similar to the following:

```
sudo docker run -it --gpus all -u $(id -u):$(id -g) -p 8888:8888  -v /home/username/:/content/mnt heatonresearch/stylegan3
```

The above command establishes the following:

* ```-u $(id -u):$(id -g)``` - This causes the user to be logged into Docker to be the same as the user running the Docker command.  This ensures that all permissions and ownerships are correct on the mounted volumes.
* ```/home/username/:/content/mnt``` - You should mount a volume to access your images and store results to.
* ```/bin/bash``` - Optional: You can start the BASH shell to allow you to execute commands.

```
cd /home/stylegan2-ada/
python dataset_tool.py create_from_images /mnt/datasets/fish /mnt/data/fish
```

Refer to readme.ipynb for information on training and converting images.
