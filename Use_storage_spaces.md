# Use of storage spaces

##  Data archival on the tape in Petastore

If your lab has purchased space on PetaStore. This is good for long-term storage of your data. If you have some data in large size and will not use them in the future for a few months, it’s a good choice to store your data here. For PanLab, our tape directory is `/archive/omicsbio/tape_2copies`. You can create your own directory here to store your own data.  
Use this interface for interactive Unix shell access to the PetaStore, and for archiving/retrieving files between the PetaStore and OSCER's cluster supercomputer filesystems (for example, /scratch and /home). More info available at [this link](https://www.ou.edu/oscer/resources/petastore). For PetaStore Access on Schooner [this link](PetaStore Access on Schooner)

1. Logging in:
    > ssh -t username@schooner.oscer.ou.edu ssh dtn2
2. Archiving a file to the PetaStore from schooner scratch
    > cp /scratch/username/file.name /archive/omicsbio/tape_2copies/file.name
3. Retrieving a file from the PetaStore to schooner scratch
    > cp /archive/omicsbio/tape_2copies/file.name /scratch/username/

**Notes**:
If you want to know more about PetaStore, see [this link](https://oscer.readthedocs.io/en/latest/petastore/).

Please make sure your files are larger than 1G. If you have large number of files with small size, consider compress them together before moving to PetaStore.

##  Persistent local storage at `/lwork` (only in private nodes)

Regarding the PanLab group. We have a partition named omicsbio. This is a local storage in each node. We currently have 6 nodes: c651, c657, c658, c659, c660 and c661. There are 600G storage space in each node. When you want to submit a job that needs large size input file or outputs large size results, it’s better to consider put the input or output here.

For instance, to access `/lwork` in each node, c651 as an example, the command is:
> ssh -t username@schooner.oscer.ou.edu ssh c651

Now you can go to c651’s lwork:
> cd /lwork

and make your directory there (create once, don’t create again when you use then later):
> mkdir /lwork/lizhang12

and then move in or out your files from there, like:
> cp /lwork/lizhang12/filename /work/omicsbio/lizhang12/filename

**Notes**:
1.	Please remember which node your data are stored, because each node is separate. You cannot access c658’s /lwork when you are running jobs on node c651. 
2.	Since you input is stored in node c651, you should set you batch script using node c651 to access the input in c651’s /lwork:
    ```
    #SBATCH --partition=omicsbio
    #SBATCH --nodelist=c651
    ```

3.	You can also do the commands above in your batch file to copy, move, make files or directories, such as cp, mv, mkdir 

## Temporary local storage at /lscratch (available both in public and omicsbio nodes)

/lscratch can just store data temporarily. When your batch job is running, you can store your input and output there, please make sure to move the output out this directory before the job finished. Once your job is done, the /lscratch will be cleaned and all the data will be deleted automatically.   Here is an example of batch file:

```bash
#!/bin/bash
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --job-name=test_lscratch
#SBATCH --mem=10M
#SBATCH --output=test_%J_stdout.txt
#SBATCH --error=test_%J_stderr.txt
#SBATCH --mail-user=lizhang12@ou.edu
#SBATCH --mail-type=END
 
cd $LSCRATCH

# check the space size in lscratch, using 1 cpu will load ~ 30G. This is according to the cpu numbers you set. If your data is more than 60G, you can set using 3 cpus.
df -h $LSCRATCH  

cp /work/omicsbio/lizhang12/input.txt  $LSCRATCH/.
cat $LSCRATCH/input.txt  >test_scratch_output.txt
 cp $LSCRATCH/test_scratch_output.txt  /work/omicsbio/lizhang12/.
 # the output file named test_scratch_output.txt will exist in directory /work/omicsbio/lizhang12
```

## Shared storage at `/work/omicsbio`

We have 1T space in `/work/omisbio`, which is shared by all the members in our lab. To check the space information, use the command:
> df –h /work/omicsbio 

You can use this command to check space size of `/lwork` and `/lscratch` as well.