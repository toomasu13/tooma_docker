
This Dockerfile sets up a Docker image based on the latest Debian distribution and installs various core packages and tools. The image is designed for running Jupyter notebooks and JupyterLab in a specific Python environment. Let's break down the Dockerfile and associated scripts:
Dockerfile:

    Base Image:

    Dockerfile

FROM debian:latest

Environment Variables:

Dockerfile

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

Install Core Packages:

Dockerfile

RUN apt-get update --fix-missing && \
    apt-get install -y \
        bzip2 \
        ca-certificates \
        curl \
        git \
        htop \
        libgtk-3-dev \
        mc \
        wget \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

Copy and Set Permissions for a Custom Script:

Dockerfile

COPY fix-permissions /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/fix-permissions

Download and Extract MicroMamba:

Dockerfile

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | \
    tar -xvj bin/micromamba

Set Environment Variables and User:

Dockerfile

# Set environment
ARG ENV_VER=py3106labfin
ARG NB_USER=toomas
ARG NB_UID=1000
ENV ENV_NAME=py3
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME=/home/${NB_USER}
ENV MAMBA_EXE=/bin/micromamba
ENV MAMBA_ROOT_PREFIX=/opt/conda

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER} && \
    ...

Create and Activate Python Environment:

Dockerfile

COPY ${ENV_VER}.yml /tmp/py3.yml
RUN micromamba env create -y -f /tmp/py3.yml

Copy Scripts and Configuration Files:

Dockerfile

COPY start_jupyter.sh /usr/local/bin/py3.sh
...
COPY custom.css ${HOME}/.jupyter/custom
COPY nbconfig/common.json ${HOME}/.jupyter/nbconfig
...

Set Permissions and Switch User:

Dockerfile

RUN fix-permissions ${HOME}

USER ${USER}

Set Working Directory and Define Entry Point and Default Command:

Dockerfile

    WORKDIR ${HOME}

    ENTRYPOINT ["bash", "-c", "/usr/local/bin/py3.sh"]
    CMD ["bash"]

start_jupyter.sh:

This script activates the Python environment and starts Jupyter Notebook and JupyterLab:

    Activates the Python environment with activate_py3.sh.
    Starts Jupyter Notebook on port 8888 and JupyterLab on port 8899.
    The --no-browser flag ensures that the browser doesn't open automatically.

activate_py3.sh:

This script uses MicroMamba to activate the specified Python environment.
Summary:

The Dockerfile creates a Debian-based Docker image, installs necessary packages, sets up a Python environment using MicroMamba, copies configuration files and scripts, and finally starts Jupyter Notebook and JupyterLab when a container is run based on this image. The image is designed to run as a non-root user with the specified UID and username.

docker build --build-arg ENV_VER=py31010lf -t py31010lf .
docker run --rm -ti -p 8996:8899 -p 8866:8888 -v /home/toomas/Dev:/home/toomas/Dev -v /home/toomas/Data:/home/toomas/Data -v /home/toomas/Dev/docker/conf:/home/toomas/.jupyter --name py31010lf py31010lf


