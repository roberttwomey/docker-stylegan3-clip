FROM nvcr.io/nvidia/pytorch:21.08-py3
LABEL maintainer="Jeff Heaton <jeff@jeffheaton.com>"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# For some reason Dockerhub hangs if I do not specify the timezone as something
ENV TZ=Etc/GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Perform updates as root
USER root
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /content

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tzdata software-properties-common sudo build-essential git git-lfs vim wget ffmpeg libssl-dev && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN pip install jupyterlab imageio imageio-ffmpeg==0.4.4 pyspng==0.1.0 scipy==1.10.1 click==8.1.3 ninja==1.11.1
RUN pip install --upgrade torch==1.11.0+cu113 torchvision==0.12.0+cu113 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install einops ninja
COPY readme.ipynb /content/
#RUN wget https://api.ngc.nvidia.com/v2/models/nvidia/research/stylegan3/versions/1/files/stylegan3-r-ffhq-1024x1024.pkl
COPY start-notebook.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-notebook.sh && \
    apt-get clean
RUN git clone https://github.com/NVlabs/stylegan3.git
RUN git clone https://github.com/openai/CLIP
RUN pip install -e ./CLIP
RUN git clone https://huggingface.co/justinpinkney/stylegan3-t-lhq-256
#COPY /content/stylegan3-t-lhq-256/lhq-256-stylegan3-t-25Mimg.pkl /content/
RUN git clone https://github.com/roberttwomey/beyond-tbb-code/
#COPY /content/beyond-tbb-code/backgrounds/CLIP-StyleGAN3.ipynb /content/
CMD ["/usr/local/bin/start-notebook.sh"]

