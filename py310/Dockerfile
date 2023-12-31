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
#		sudo \
		wget \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY fix-permissions /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/fix-permissions


RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | \
    tar -xvj bin/micromamba

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
    mkdir -p /etc/sudoers.d && \
    echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook && \
    chmod 0440 /etc/sudoers.d/notebook

COPY ${ENV_VER}.yml /tmp/py3.yml
RUN micromamba env create -y -f /tmp/py3.yml

RUN touch /root/.bashrc && \
	./bin/micromamba shell init -s bash -p /opt/conda && \
	grep -v '[ -z "\$PS1" ] && return' ~/.bashrc  > /opt/conda/bashrc
#RUN fix-permissions ${MAMBA_ROOT_PREFIX}

COPY start_jupyter.sh /usr/local/bin/py3.sh
RUN chmod +x /usr/local/bin/py3.sh

COPY activate_py3.sh /usr/local/bin/activate_py3.sh
RUN chmod +x /usr/local/bin/activate_py3.sh

RUN mkdir -p ${HOME}/.jupyter/custom  && mkdir -p ${HOME}/.jupyter/nbconfig

COPY custom.css ${HOME}/.jupyter/custom
COPY nbconfig/common.json ${HOME}/.jupyter/nbconfig
COPY nbconfig/edit.json ${HOME}/.jupyter/nbconfig
COPY nbconfig/notebook.json ${HOME}/.jupyter/nbconfig
COPY jupyter_notebook_config.json ${HOME}/.jupyter

RUN fix-permissions ${HOME}

# Switch to the non-root user
USER ${USER}

# Set the working directory
WORKDIR ${HOME}

ENTRYPOINT ["bash", "-c", "/usr/local/bin/py3.sh"]

CMD ["bash"]
