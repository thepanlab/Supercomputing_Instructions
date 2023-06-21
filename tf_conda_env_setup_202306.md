# Setting up tensorflow conda environment on Jacobian (for GPU)

Justin Reynolds \
June, 2023

https://www.tensorflow.org/install/pip

Login to schooner login node
```
ssh jreynolds@schooner.oscer.ou.edu
(enter password)
```
Assumming conda is already installed, create a new conda environment (not in home directory due to schooner disk space limitations in home directory)
```
conda create -p /ourdisk/hpc/nullspace/jreynolds/dont_archive/tfgpu python=3.9
```

Login to node c822 (Jacobian partition)
```
ssh c822
(enter password)
```

Activate the new conda environment
```
conda activate /ourdisk/hpc/nullspace/jreynolds/dont_archive/tfgpu
```

Install all desired packages other than tensorflow with conda-forge
```
conda install -c conda-forge pandas numpy jupyterlab ipywidgets tqdm scikit-learn scipy matplotlib seaborn opencv
```

Install CUDA (cudatoolkit) with conda-forge
```
conda install -c conda-forge cudatoolkit=11.8.0
```

Install cuDNN with pip
```
pip install nvidia-cudnn-cu11==8.6.0.163
```

Configure the system paths with the following command every time a new terminal session is started (or slurm job is submitted) after activating your conda environment. See the sample sbatch file below. 

```
# configure path
CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))

# assign path to environment variable for shared libraries
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib
```

Upgrade pip if necessary and install tensorflow
```
# upgrade pip
pip install --upgrade pip

# install tensorflow
pip install tensorflow==2.12.*
```

Now check to see if it is working; however, it is likely that there will be an error that says something along the lines of ```InternalError: libdevice not found at ./libdevice.10.bc [Op:__some_op]```. 

To resolve this problem, log back into c822, activate the conda environment (jacobian partition) and run the following
```
# Note: make sure to disable channel priority beforehand
conda config --set channel_priority disabled

# Install NVCC
conda install -c nvidia cuda-nvcc=11.3.58

# Configure the XLA cuda directory
mkdir -p $CONDA_PREFIX/etc/conda/activate.d

printf 'export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CONDA_PREFIX/lib/\n' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh

source $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh

# Copy libdevice file to the required path
mkdir -p $CONDA_PREFIX/lib/nvvm/libdevice

cp $CONDA_PREFIX/lib/libdevice.10.bc $CONDA_PREFIX/lib/nvvm/libdevice/
```

Sample slurm sbatch file for running jupyter lab on the first GPU of jacobian:


**jupy.sbatch**
```
#!/bin/bash

#SBATCH --partition=jacobian
#SBATCH --mem=0
#SBATCH --output=_jupy_%J_stdout.log
#SBATCH --error=_jupy_%J_stderr.err
#SBATCH --mail-user=<USER_EMAIL>
#SBATCH --mail-type=ALL
#SBATCH --time=30-00:00:00
#SBATCH --job-name=jupy
#SBATCH --exclusive
#SBATCH --chdir=/home/<USERNAME>
#################################################

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="schooner"
port=8893

# print tunneling instructions jupyter-log
echo -e "
lsof -ti:${port} | xargs kill -9
ssh -N -f -L ${port}:${node}:${port} ${user}@${cluster}.oscer.ou.edu
localhost:${port}  (prefix w/ https:// if using password)
"

# start conda and activate the environment
. /home/jreynolds/conda_setup.sh

conda activate /ourdisk/hpc/nullspace/jreynolds/dont_archive/tfgpu

# https://www.tensorflow.org/install/pip
CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib

CUDA_VISIBLE_DEVICES=0 jupyter lab --no-browser --port=${port} --ip=0.0.0.0
```

