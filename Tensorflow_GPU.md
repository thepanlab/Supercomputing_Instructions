# Tensorflow GPU environment setup

## Description
The following steps and setup should work for blazer, thunder and laker, please note that the specific version of tensorflow is for the medical imaging pipeline (currently 2.6.2 and 2.15 works), so if not using the pipeline, any version will be fine. Also, try not to install the tensorflow ranking package after everything is built, it may lead to the failure of your working environment.


### Install the miniconda or anaconda

```shell
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh
```

```shell
bash Miniconda3-py39_4.11.0-Linux-x86_64.sh
```
I'm using miniconda as the example, you may want to install it in your home directory.

### Setting conda-forge

```shell
conda config --show channels
conda config --add channels conda-forge
conda config --set channel_priority strict
```
This step is important, it will ensure when installing tensorflow it will also install the compatible cudatoolkit and cudnn with respect to the nvidia driver and tensorflow so you don't have to install them manually. You can also you `conda list` to check whether the channels are in conda-forge.

### Create conda environment
```shell
conda create -n <env_name> python=3.9
conda activate <env_name>
```
Make sure this step is running on your base conda environment.

### Install tensorflow
```shell
conda install tensorflow=2.6.2
```
`tf.config.list_physical_devices('GPU')` can be used to verify if using GPU.  
Huge thanks to Justin for helping me with setting the environment!
