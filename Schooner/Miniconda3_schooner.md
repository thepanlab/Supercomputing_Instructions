# Miniconda3 on Schooner and Jacobian




## Download Miniconda for Linux

```
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh
```

## Check integrity of downloaded file 
Should be in directory of the downloaded file. 

```
sha256sum Miniconda3-py39_4.11.0-Linux-x86_64.sh
```


## Install Miniconda

```
bash Miniconda3-py39_4.11.0-Linux-x86_64.sh
```

- Press ENTER to continue
- Then, the license agreement is displayed. Press ENTER to jump to the bottom of the licencse terms and type "yes" and press ENTER to agree. 
- The installer will the ask where to store Miniconda. Press ENTER for home directory installation. 
- Lastly, the installer will ask to initialize Miniconda. Type "yes" and press enter. 
- Now, logout and login again. 

## Disallow automatic activation of base conda env

By default, the conda base env will be automatically activated each time you login. To disable this:

```
conda config --set auto_activate_base false
```

This will create a file named .condarc which tells conda not to activate the base env each time we login. 

## Move the conda initialization out of .bashrc

After installing Miniconda3, the code below is injected into .bashrc automatically. Comment this out of the conda initialization in the .bashrc, move it to a new file (e.g., conda_setup.sh), and provide a reference to the newly created conda initialization file inside .bashrc. The permissions on the conda initialization file should support user execution. 

For example, the .bashrc:

```
[jreynolds@schooner1 ~]$ cat .bashrc 
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/jreynolds/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/jreynolds/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/jreynolds/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/jreynolds/miniconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

. /home/jreynolds/conda_setup.sh
```

And the new conda initialization file:

```
[jreynolds@schooner1 ~]$ cat conda_setup.sh 
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jreynolds/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jreynolds/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jreynolds/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jreynolds/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
```

Lastly, change the permissions on the initialization file:

```
chmod u=rwx conda_setup.sh
```

## Create a conda environment

There are several ways to create a conda environment. One way to do it is by using a .yml file with all the necessary python packages and libraries listed inside. A sample .yml which installs tensorflow and other useful packages is available in this repo, name tf_environment.yml. To create an env (named tf) with tf_environment.yml can be done as follows:

First, activate the base environment. 

```
conda activate
```

In the same directory as tf_environment.yml, create the environment. Note: this will take some time.

```
conda env create -f tf_environment.yml
```

- Big thanks to Dr. Fagg for providing the .yml file

Once the packages are installed, the environment can be activated as follows.

```
conda activate tf
```

## Using conda environment in a batch script

Below is sample batch script which activates and uses the new **tf** conda environment on the jacobian paritition. 

```
#!/bin/bash
#
#SBATCH --partition=jacobian
#SBATCH --ntasks=1
#SBATCH --output=results/fancy_exp%J_stdout.log
#SBATCH --error=results/fancy_exp%J_stderr.err
#SBATCH --time=00:20:00
#SBATCH --job-name=fancy
#SBATCH --mail-user=my_email@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --chdir=/work/omicsbio/username/...
##############################

# Initialize conda
. /home/jreynolds/conda_setup.sh

# Activate tf environment
conda activate tf

# Run the program on a single GPU
CUDA_VISIBLE_DEVICES=1 python my_fancy_program.py
```

## Environment storage location management
 
Store environments in a location other than home to avoid running out of disk space. In the same directory where Miniconda is installed, insert the following in a file name```.condarc```.

```
pkgs_dirs: 
  - /work/omicsbio/jreynolds/conda/pkgs 
envs_dirs: 
  - /work/omicsbio/jreynolds/conda/envs
```