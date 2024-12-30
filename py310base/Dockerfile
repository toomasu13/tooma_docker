FROM debian:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install core
RUN apt-get update --fix-missing && \
    apt-get install -y \
        bzip2 \
        ca-certificates \
        curl \
        git \
        htop \
        libgtk-3-dev \
        mc \
        sudo \
        wget \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | \
    tar -xvj bin/micromamba

COPY fix-permissions /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/fix-permissions

# Set environment
ARG PY_VER=py31010
ARG ARG_USER=jupyter
ARG ARG_UID=1000
ARG ARG_GID=1000
ENV ENV_NAME=py3
ENV USER=${ARG_USER}
ENV UID=${ARG_UID}
ENV GID=${ARG_GID}
ENV HOME=/home/${ARG_USER}
ENV MAMBA_EXE=/bin/micromamba
ENV MAMBA_ROOT_PREFIX=/opt/conda

# Create user
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${UID} \
    ${USER} && \
    mkdir -p /etc/sudoers.d && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook && \
    chmod 0440 /etc/sudoers.d/notebook

COPY start_jupyter.sh /usr/local/bin/py3.sh
RUN chmod +x /usr/local/bin/py3.sh

COPY activate_py3.sh /usr/local/bin/activate_py3.sh
RUN chmod +x /usr/local/bin/activate_py3.sh

RUN mkdir -p ${MAMBA_ROOT_PREFIX}/conda-meta
RUN chmod -R a+rwx ${MAMBA_ROOT_PREFIX} 

RUN touch /root/.bashrc && \ 
    ${MAMBA_EXE} shell init -s bash -r ${MAMBA_ROOT_PREFIX} && \
    grep -v '[ -z "\$PS1" ] && return' ~/.bashrc  > /opt/conda/bashrc

# Jupyter config
RUN mkdir -p ${HOME}/.jupyter/custom  && mkdir -p ${HOME}/.jupyter/nbconfig

COPY nbconfig/custom.css ${HOME}/.jupyter/custom
COPY nbconfig/common.json ${HOME}/.jupyter/nbconfig
COPY nbconfig/edit.json ${HOME}/.jupyter/nbconfig
COPY nbconfig/notebook.json ${HOME}/.jupyter/nbconfig
COPY nbconfig/jupyter_notebook_config.json ${HOME}/.jupyter

RUN fix-permissions ${HOME}

# Switch to the non-root user
USER ${USER}

# The spec file
COPY ${PY_VER}.yml ${HOME}/py3.yml

# Create env 
RUN micromamba env create -y -f ${HOME}/py3.yml && \ 
    micromamba clean -a -y -f && \
    rm -rf ${HOME}/py3.yml

# Set the working directory
WORKDIR ${HOME}

CMD ["bash"]
