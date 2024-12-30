
# Set environment
ARG PY_VER=py31010

FROM ${PY_VER}:latest

ARG ENV_VER=py31010sl

COPY ${ENV_VER}.yml ${HOME}/py3.yml

RUN micromamba install -y -f ${HOME}/py3.yml && \ 
    micromamba clean -a -y -f && \
    rm -rf ${HOME}/py3.yml

COPY ${ENV_VER}.sh /usr/local/bin/py3.sh
RUN sudo chmod +x /usr/local/bin/py3.sh

RUN mkdir -p ${HOME}/.streamlit  && mkdir -p ${HOME}/app

COPY streamlit/streamlit_app.py ${HOME}/app
COPY streamlit/config.toml  ${HOME}/.streamlit

# Streamlit	
EXPOSE 8501
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["bash", "-c", "/usr/local/bin/py3.sh"]


