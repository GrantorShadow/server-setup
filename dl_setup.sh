#!/bin/bash

# Print ASCII art banner
echo " ██████╗ ██╗     ███████╗███████╗ ██████╗██╗   ██╗██╗     ███████╗"
echo "██╔════╝ ██║     ██╔════╝██╔════╝██╔════╝██║   ██║██║     ██╔════╝"
echo "██║  ███╗██║     █████╗  ███████╗██║     ██║   ██║██║     █████╗  "
echo "██║   ██║██║     ██╔══╝  ╚════██║██║     ██║   ██║██║     ██╔══╝  "
echo "╚██████╔╝███████╗███████╗███████║╚██████╗╚██████╔╝███████╗███████╗"
echo " ╚═════╝ ╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝"
echo "            Setup your deep learning server with ease!             "
echo ""

# Check NVIDIA GPU and CUDA installation
if ! nvidia-smi > /dev/null; then
    echo "NVIDIA GPU is not available. Please check your setup."
    exit 1
fi

# Function to check if a package is installed
is_installed() {
    dpkg -s "$1" > /dev/null 2>&1
}

# Check if required libraries for deep learning are installed
if is_installed libhdf5-dev && is_installed libc-ares-dev && is_installed libeigen3-dev && is_installed libatlas-base-dev && is_installed libopenblas-dev && is_installed libblas-dev && is_installed liblapack-dev && is_installed gfortran; then
    echo "Required libraries for deep learning are already installed."
else
    echo "Required libraries for deep learning are not installed. Installing them..."
    sudo apt-get update
    sudo apt-get install -y libhdf5-dev libc-ares-dev libeigen3-dev libatlas-base-dev libopenblas-dev libblas-dev liblapack-dev gfortran
fi

# Check if Miniconda is installed
if which conda > /dev/null; then
    echo "Miniconda is already installed."
else
    echo "Miniconda is not installed. Downloading and installing Miniconda..."
    
    # Download and install Miniconda
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b
    rm -f Miniconda3-latest-Linux-x86_64.sh
fi

# Activate conda environment
source ~/miniconda3/etc/profile.d/conda.sh
conda activate base

# Install required Python packages
if pip3 list | grep -E '^numpy\s|^pandas\s|^matplotlib\s|^scikit-learn\s' > /dev/null; then
    echo "Required Python packages are already installed."
else
    echo "Required Python packages are not installed. Installing them..."
    pip3 install numpy pandas matplotlib scikit-learn
fi

# Check NVIDIA GPU and CUDA installation
nvidia-smi
