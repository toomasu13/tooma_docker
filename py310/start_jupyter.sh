#!/bin/bash

source /usr/local/bin/activate_py3.sh

echo 'Book'
jupyter notebook --notebook-dir /home/toomas --ip='*' --port=8888 --no-browser --allow-root &> /dev/null &
echo 'Lab'
jupyter lab --notebook-dir /home/toomas --ip='*' --port=8899 --no-browser --allow-root &> /dev/null &

echo 'Docker bash'
bash
echo 'Done'
