## Accessing Jacobian

Login to a schooner login node.

```
ssh jreynolds@schooner.oscer.ou.edu
```

Login into the Jacobian partion.

```
ssh c822
```

## Setting up a conda environment

```
module load OpenMPI/4.0.3-GCC-9.3.0 
module load CUDA/11.3.1
module load cuDNN/8.2.1.32-CUDA-11.3.1
module load Miniconda3
source activate
conda create -n torch python=3.8
conda activate torch
conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch
```
Now you can run your code once your application's dependencies are installed in the conda environment. 

## Batch script on Jacobian

After finished setting up the conda environment on Jacobian, you can go ahead and logout of Jacobian if running a batch script. In other words, the batch script should be submitted from a login node. 

A sample batch script **sample.batch**:

```
#!/bin/bash

#SBATCH --partition=jacobian
#SBATCH --ntasks=8
#SBATCH --output=_%J.log
#SBATCH --error=_%J.err
#SBATCH --nodelist c822
#SBATCH --time=00:15:00
#SBATCH --job-name=torch_catsvdogs
#SBATCH --chdir=/work/omicsbio/jreynolds/projects/pytorch-explore/pytorch_tutorials
#################################################

module purge
module load OpenMPI/4.0.3-GCC-9.3.0 
module load CUDA/11.3.1
module load cuDNN/8.2.1.32-CUDA-11.3.1
module load Miniconda3

source activate
conda activate torchy
python cnn_torch_catsvdogs.py -g 1
conda deactivate
conda deactivate
module remove Miniconda3
```

Submitting the batch script:

```
sbatch sample.batch
``` 
