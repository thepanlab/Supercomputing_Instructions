# Use jupyter notebook

## Configuration batch file

Use the file `pJupyter.batch` inside the *Use_jupyter_notebook*, you would need to modify:

The partition you are using:

> #SBATCH --partition=omicsbio

The number of tasks

> #SBATCH --ntasks=10

The memory size you want to use:

> #SBATCH --mem=10G

*(Optional)* The nodes you would like to use

> #SBATCH --nodelist=c660

Time to run:

> #SBATCH --time=12:00:00

Working directory

> #SBATCH --chdir=/work/omicsbio/paulcalle/

Change the port, according to your setup

> port=8893

Load the modules that you'll use

e.g.

> module load Python/3.6.4-foss-2018a </br>
module load TensorFlow/1.8.0-foss-2018a-Python-3.6.4

## Setup port(Windows)

In Putty: