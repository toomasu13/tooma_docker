#!/bin/bash

eval "$(micromamba shell hook --shell bash)"
micromamba activate $ENV_NAME
echo 'micromamba environment ' $ENV_NAME

