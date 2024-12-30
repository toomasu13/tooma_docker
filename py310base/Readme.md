# Python 31010 Base Docker Image

This Docker image provides a pre-configured development environment based on Debian, with Micromamba for Conda environment management and both Jupyter Notebook and JupyterLab support. It includes essential development tools and a customizable Python environment.

## Key Features

* **Debian Base:** Built on the latest Debian image for stability and security.
* **Core Development Tools:** Includes essential tools like `curl`, `git`, `wget`, `htop`, `mc`, `sudo`, and `bzip2`.
* **Micromamba:**  Provides a fast and efficient package manager for creating and managing isolated Python environments.
* **Customizable Python Environment:**  Allows specifying the Python version during build time.
* **Non-Root User:** Runs processes as a non-root user (`toomas` by default) for enhanced security.
* **Jupyter Ready:** Pre-configured for both Jupyter Notebook and JupyterLab, accessible without tokens or passwords.
* **Easy Environment Creation:** Creates a Conda environment based on a provided YAML file.
* **Simultaneous Jupyter Notebook and Lab:** Starts both Jupyter Notebook and JupyterLab on different ports.
* **Interactive Bash Shell:**  Opens a Bash shell after starting Jupyter services.

## Prerequisites

* Docker installed on your system.

## Building the Image

1. **Save the Dockerfile:** Ensure the provided Dockerfile is saved as `Dockerfile.base` in your project directory.
2. **Create the environment YAML file:** Create a YAML file (e.g., `py31010sl.yml`) in the same directory as your Dockerfile. This file should list the additional Python packages your project needs, including Streamlit and any data science libraries. For example:

   ```yaml
   name: py3
   channels:
     - conda-forge
   dependencies:
     - python=3.10.10  # Or your desired Python version
     - pandas
     - numpy
     - pip:
         - arcticdb
         - streamlit
     # Add other dependencies here
   ```

2. **Navigate to the directory:** Open your terminal and navigate to the directory containing the `Dockerfile.base`.
3. **Build the image:** Run the following command to build the Docker image. You can customize the Python version, username, and user ID using the build arguments:

   ```bash
   docker build -f Dockerfile.base \
       --build-arg PY_VER=py31010 \
       --build-arg ARG_USER=toomas \
       --build-arg ARG_UID=1000 \
       -t py31010 .
   ```

   **Explanation of build arguments:**

   * `--build-arg PY_VER=py31010`: Specifies the Python version to be used for the Conda environment. You'll need a corresponding YAML file (e.g., `py31010.yml`) in the same directory as your Dockerfile. This YAML file should define the Python version and any other packages you want to install in the base environment.
   * `--build-arg ARG_USER=toomas`: Sets the username for the non-root user.
   * `--build-arg ARG_UID=1000`: Sets the user ID for the non-root user. Matching your host user ID can help with file permission issues when mounting volumes.
   * `-t py31010`: Tags the image with the name `py31010`.

## Running the Container and Accessing Jupyter

To run the Docker image, use the following command:

```bash
docker run --rm -ti -p 8888:8888 -p 8899:8899 --name py31010 py31010 bash
```

**Explanation of options:**

* `docker run`:  Starts a container.
* `--rm`: Automatically removes the container when it exits.
* `-ti`: Allocates a pseudo-TTY connected to the container and keeps STDIN open, allowing you to interact with the shell.
* `-p 8888:8888`: Maps port 8888 of the container to port 8888 on your host machine (for Jupyter Notebook).
* `-p 8899:8899`: Maps port 8899 of the container to port 8899 on your host machine (for JupyterLab).
* `--name py31010`: Assigns the name `py31010` to the running container.
* `py31010`: Specifies the image to run.
* `bash`:  Executes the `bash` command inside the container.

**Accessing Jupyter:**

Once the container is running, the `py3.sh` script is automatically executed when you enter the container via `bash`. 

```bash
bash -c /usr/local/bin/py3.sh
```

This script starts:

* **Jupyter Notebook:** Accessible in your web browser at `http://localhost:8888`.
* **JupyterLab:** Accessible in your web browser at `http://localhost:8899`.

Both Jupyter Notebook and JupyterLab are configured to run without requiring a token or password.

**Inside the Container:**

After Jupyter services are started, you will be presented with a Bash prompt within the container. You can interact with the file system, manage your Conda environment, and perform other development tasks.

## Using the Conda Environment

Once inside the container, the Conda environment named `py3` (defined by `ENV_NAME=py3` in the Dockerfile) will be automatically activated. You can verify this by checking the prefix in your shell prompt.

You can then use standard Conda/Micromamba commands to manage your environment:

* **List installed packages:**
  ```bash
  micromamba list
  ```
* **Install new packages:**
  ```bash
  micromamba install <package_name>
  ```
* **Deactivate the environment (if needed):**
  ```bash
  conda deactivate
  ```
* **Activate the environment (if deactivated):**
  ```bash
  conda activate py3
  ```

## Customization

* **Python Version and Packages:** Customize the Python version and install specific packages by creating a YAML file (e.g., `py31010.yml`) and providing its name as the `PY_VER` build argument. The Dockerfile will automatically use this file to create the Conda environment.
* **Username and User ID:** Change the default username (`toomas`) and user ID (`1000`) by modifying the `ARG_USER` and `ARG_UID` build arguments.
* **Adding More Tools:**  Modify the `Dockerfile.base` to install additional software or libraries as needed.

## Included Tools

* `bzip2`
* `ca-certificates`
* `curl`
* `git`
* `htop`
* `libgtk-3-dev`
* `mc`
* `sudo`
* `wget`
* `micromamba`
* Jupyter Notebook
* JupyterLab

## Contributing

Feel free to contribute to this Docker image by submitting pull requests.

## License

[Specify your license here if applicable]
