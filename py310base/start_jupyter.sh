#!/bin/bash

source /usr/local/bin/activate_py3.sh

echo 'Streamlit '
echo 'URL: http://0.0.0.0:8501'
streamlit run ${HOME}/app/streamlit_app.py --server.port=8501 --server.address=0.0.0.0 &> /dev/null &
echo 'Book'
jupyter notebook --notebook-dir ${HOME} --ip='*' --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password='' &> /dev/null &
echo 'Lab'
jupyter lab --notebook-dir ${HOME} --ip='*' --port=8899 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password='' &> /dev/null &

echo 'Docker bash'
bash
echo 'Done'
