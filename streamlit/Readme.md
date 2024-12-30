# Streamlit Docker Image

This Docker image builds upon the `py31010` image to provide a comprehensive development environment with Streamlit, Jupyter Notebook, and JupyterLab, all managed by Micromamba. It offers a ready-to-use platform for data science and web application development within a consistent and isolated environment.

## Key Features

* **Integrated Development Environment:** Combines Streamlit for building interactive web applications with Jupyter Notebook and JupyterLab for data exploration and analysis.
* **Built upon `py31010`:** Inherits all the features and tools from the robust `py31010` base image.
* **Enhanced Python Environment:** Installs additional Python packages specified in a YAML file (e.g., `py31010sl.yml`) using Micromamba, enabling specific project requirements.
* **Pre-configured Streamlit:** Includes Streamlit and automatically starts your application defined in `streamlit_app.py`.
* **Jupyter Ready:** Seamlessly supports both Jupyter Notebook and JupyterLab.
* **Port Mappings:** Exposes necessary ports for Streamlit, Jupyter Notebook, and JupyterLab, making them accessible from your host machine.
* **Volume Mounts:** Provides instructions for mounting local directories, facilitating code editing and data access outside the container.
* **Non-Root User:** Ensures enhanced security by running processes under a non-root user.

## Prerequisites

* Docker installed on your system.
* The `py31010` Docker image must be built and available locally.

## Building the Image

1. **Save the Dockerfile:** Ensure the provided Dockerfile is saved as `Dockerfile` in your project directory.
2. **Create the environment YAML file:** Create a YAML file (e.g., `py31010sl.yml`) in the same directory as your Dockerfile. This file should list the additional Python packages your project needs, including Streamlit and any data science libraries. For example:

   ```yaml
   name: py3
   channels:
     - conda-forge
   dependencies:
     - python=3.10.10  # Or your desired Python version
     - streamlit
     - pandas
     - numpy
     # Add other dependencies here
   ```

3. **Navigate to the directory:** Open your terminal and navigate to the directory containing the `Dockerfile` and the YAML file.
4. **Build the image:** Execute the following command to build the Docker image:

   ```bash
   docker build -f Dockerfile \
       --build-arg PY_VER=py31010 \
       --build-arg ENV_VER=py31010sl \
       -t py31010sl .
   ```

   **Explanation of build arguments:**

   * `--build-arg PY_VER=py31010`: Specifies the tag of the base image (`py31010`). Ensure this base image is built locally.
   * `--build-arg ENV_VER=py31010sl`: Specifies the filename of your environment YAML file (`py31010sl.yml`).
   * `-t py31010sl`: Tags the resulting image with the name `py31010sl`.

## Running the Container and Accessing Applications

To run the Docker image and start all the services, use the following command:

```bash
docker run --rm -ti \
    -p 8996:8899 \
    -p 8866:8888 \
    -p 8501:8501 \
    -p 8000:8000 \
    -p 8109:8109 \
    -p 5000:5000 \
    -v /home/toomas/Dev:/home/toomas/Dev \
    -v /home/toomas/Data:/home/toomas/Data \
    -v /home/toomas/Dev/streamlit:/home/toomas/app \
    -v /home/toomas/Dev/docker/conf:/home/toomas/.jupyter \
    --name py31010sl py31010sl
```

**Explanation of options:**

* `docker run`: Starts a new container.
* `--rm`: Automatically removes the container when it exits.
* `-ti`: Allocates a pseudo-TTY and keeps STDIN open for interactive shell access.
* `-p 8996:8899`: Maps the container's JupyterLab port (8899) to port 8996 on your host.
* `-p 8866:8888`: Maps the container's Jupyter Notebook port (8888) to port 8866 on your host.
* `-p 8501:8501`: Maps the container's Streamlit port (8501) to port 8501 on your host.
* `-p 8000:8000`, `-p 8109:8109`, `-p 5000:5000`: Maps additional ports for potential future use or other services you might run.
* `-v /home/toomas/Dev:/home/toomas/Dev`: Mounts your local development directory to `/home/toomas/Dev` inside the container. **Adapt the host path (`/home/toomas/Dev`) to your actual local directory.**
* `-v /home/toomas/Data:/home/toomas/Data`: Mounts your local data directory to `/home/toomas/Data` inside the container, providing access to your datasets. **Adapt the host path (`/home/toomas/Data`) to your actual local directory.**
* `-v /home/toomas/Dev/streamlit:/home/toomas/app`: Mounts your local Streamlit application directory to `/home/toomas/app` inside the container. Changes to your Streamlit code will be reflected live. **Adapt the host path (`/home/toomas/Dev/streamlit`) to your actual local directory.**
* `-v /home/toomas/Dev/docker/conf:/home/toomas/.jupyter`: Mounts your local Jupyter configuration directory to the container's Jupyter configuration, allowing you to share settings. **Adapt the host path (`/home/toomas/Dev/docker/conf`) to your actual local directory.**
* `--name py31010sl`: Assigns the name `py31010sl` to the running container.
* `py31010sl`: Specifies the image to run.

**Accessing Applications:**

Once the container is up and running, the `py3.sh` script starts all the services in the background. You can access them via your web browser:

* **Streamlit Application:**  Navigate to `http://localhost:8501`.
* **Jupyter Notebook:** Navigate to `http://localhost:8866`.
* **JupyterLab:** Navigate to `http://localhost:8996`.

After the services start, you'll be dropped into a Bash shell within the container, allowing you to interact with the environment.

## Using the Conda Environment

The Conda environment named `py3` (defined and extended by your YAML files) is automatically activated when you access the shell within the container. You can manage packages using Micromamba:

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

* **Python Packages:** Modify the `py31010sl.yml` file to add, remove, or update Python packages and rebuild the image.
* **Streamlit Application:** Develop your Streamlit application by modifying the Python files in your local `streamlit` directory, which is mounted to `/home/toomas/app` inside the container.
* **Jupyter Configuration:** Customize Jupyter Notebook and Lab through the configuration files in your local `docker/conf` directory.

## Included Tools

* All tools from the `py31010` base image (including `micromamba`, `curl`, `git`, etc.).
* Streamlit
* Jupyter Notebook
* JupyterLab

## Contributing

Contributions to this Docker image are welcome. Please submit pull requests with your improvements.

## License

[Specify your license here if applicable]
