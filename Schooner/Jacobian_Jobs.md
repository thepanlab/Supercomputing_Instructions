# Jacobian Jobs

Justin Reynolds 

Last updated: 4/13/2022

## Transferring data to lscratch

To speedup execution of jobs on Jacobian (node c822) datasets should first be transferred to **lscratch** in the batch file. 

Why is lscratch necessary? I/O for Jacobian jobs is slow when large datasets are stored elsewhere. Transferring data to lscratch allows for dramatically faster access to the data. 

For example, in the batch script below, a dataset is in the form of a zip file is located on ourdisk. Upon submitting the batch script to the slurm scheduler, the dataset is unzipped into lscratch from ourdisk before executing the python code. Then, the python code uses the dataset which is temporarily stored in lscratch to run the experiment. Note, the dataset will be deleted from lscratch when the job terminates. 

If the data is comprised of many files, then it would be best for the dataset to be compressed into a single file (zip or tar) for the copying to lscratch procedure to be efficient. Otherwise, if there are many files, copying to lscratch may take a long time. 

In the batch script, lscratch can be accessed with ```$LSCRATCH```.

ourdisk: ```/ourdisk/hpc/nullspace/```


```
#!/bin/bash
#
#SBATCH --partition=jacobian
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --output=results_demo/demo_stdout.log
#SBATCH --error=results_demo/demo_stderr.err
#SBATCH --time=02:00:00
#SBATCH --job-name=demo
#SBATCH --chdir=/work/omicsbio/jreynolds/demo
##############################

# Activate conda env
. /home/jreynolds/conda_setup.sh
conda activate tf

# Display the lscratch directory used for this job
echo "lscratch location is $LSCRATCH"

# Unzip the dataset into lscratch
unzip /ourdisk/hpc/nullspace/jreynolds/auto_archive_notyet/tape_2copies/backup_JR/datasets/core50_hw3.zip -d $LSCRATCH

# Run code with dataset in lscratch
CUDA_VISIBLE_DEVICES=0 python demo.py --dataset "$LSCRATCH/core50_128x128"

```