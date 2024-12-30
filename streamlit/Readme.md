
This Dockerfile sets up a Docker image based on the latest Debian distribution and installs various core packages and tools. The image is designed for running Jupyter notebooks and JupyterLab in a specific Python environment. Let's break down the Dockerfile and associated scripts:


py31010sl.sh:

This script activates the Python environment and starts Jupyter Notebook and JupyterLab:

    Activates the Python environment with activate_py3.sh.
    Starts Jupyter Notebook on port 8888 and JupyterLab on port 8899.
    The --no-browser flag ensures that the browser doesn't open automatically.

Summary:

The Dockerfile creates a Debian-based Docker image, installs necessary packages, sets up a Python environment using MicroMamba, copies configuration files and scripts, and finally starts Jupyter Notebook and JupyterLab when a container is run based on this image. The image is designed to run as a non-root user with the specified UID and username.

docker build -f Dockerfile --build-arg PY_VER=py31010 --build-arg ENV_VER=py31010sl -t py31010sl . 

docker run --rm -ti -p 8996:8899 -p 8866:8888 -p 8501:8501 -p 8000:8000 -p 8109:8109 -p 5000:5000 -v /home/toomas/Dev:/home/toomas/Dev -v /home/toomas/Data:/home/toomas/Data  -v /home/toomas/Dev/streamlit:/home/toomas/app -v /home/toomas/Dev/docker/conf:/home/toomas/.jupyter --name py31010sl py31010sl


