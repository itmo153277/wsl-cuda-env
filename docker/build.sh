#!/bin/bash

cd $(dirname "$0")
exec docker build -t viktprog/cuda-env .
