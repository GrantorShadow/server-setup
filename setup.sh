#!/bin/bash

# Install CUDA and NVIDIA drivers
sudo apt-get update
sudo apt-get install -y linux-headers-$(uname -r)
sudo apt-get install -y build-essential
sudo apt-get install -y wget
sudo wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda

# Install cuDNN
CUDNN_VERSION="8.5.48-1+cuda11.5"
wget https://developer.download.nvidia.com/compute/redist/cudnn/v8.2.2/ubuntu20.04-x64/libcudnn8-dev_8.2.2.26-1+cuda11.5_amd64.deb
sudo dpkg -i libcudnn8-dev_8.2.2.26-1+cuda11.5_amd64.deb

# Install other required libraries for deep learning
sudo apt-get install -y libhdf5-dev libc-ares-dev libeigen3-dev libatlas-base-dev libopenblas-dev libblas-dev liblapack-dev gfortran
sudo apt-get install -y python3-dev python3-pip
pip3 install numpy pandas matplotlib scikit-learn tensorflow-gpu

# Download and install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
rm -f Miniconda3-latest-Linux-x86_64.sh

# Activate conda environment
source ~/miniconda3/etc/profile.d/conda.sh
conda activate base

# Check NVIDIA GPU and CUDA installation
nvidia-smi
nvcc --version
cat /usr/local/cuda/version.txt
