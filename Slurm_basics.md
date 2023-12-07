# Slurm basics

## Information of partition
For my lab, we have the partition name: omicsbio. Change according to your partition.
> sinfo -p omicsbio

-p: partition

Output: 

      PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST  
      omicsbio     up   infinite      2    mix c[658,661] 
      omicsbio     up   infinite      4   idle c[651,657,659-660]


Note: if -p is not specified (i.e. _sinfo_), all partitions nodes are shown

## Jobs in partition
To see jobs running in a specific partition:
> squeue -p omicsbio

-p: partition <br>

Output:

         JOBID PARTITION     NAME     USER ST        TIME  NODES NODELIST(REASON) 
      28204348  omicsbio       ko lizhang1  R  1-13:17:11      1 c657
      28000091  omicsbio jupyter-  adbadre  R 10-00:09:16      1 c660
      27996452  omicsbio jupyter-  adbadre  R 10-04:47:54      1 c659

To see jobs running for a specific user:
-u: user <br>

> squeue -u adbadre

Output:

         JOBID  PARTITION     NAME     USER ST        TIME  NODES NODELIST(REASON) 
      28000091   omicsbio jupyter-  adbadre  R 10-00:09:16      1 c660
      27996452   omicsbio jupyter-  adbadre  R 10-04:47:54      1 c659

Note: If -p nor u is specified, it shows all jobs in all partitions

## Cancel jobs

> scancel jobid <br>

e.g. <br>
> scancel 28204348


# Batch commands
Include these batch instructions when submitting your job.

### Requesting a specific node
If you find node c657 is not used, and then you want to submit jobs specificly to this node. You can add the setting to the batch scripts :

> #SBATCH --nodelist=c657

### Excluding Specific Nodes
If you find node c651 or other nodes like c657 are running plenty of jobs, but it still has resources to share for running other jobs. You want your jobs avoid using these nodes. Actually our pending jobs are prior to be assigned to node c651, if it is available. You can exclude these nodes when submitting jobs:

> #SBATCH --exclude=c651,c657

### Check the memory and CPUs used in a specific node
Login to this node and use `top` command

> ssh c651  # this is login command <br>
> top

Use `q` to quit from top 
> $  exit   # logout from this node

### Exclusive access to computing nodes

If you do not want your jobs share a node with other running jobs:

> #SBATCH --exclusive

# Get Information

## Used space quota

In order to see the space used in your home directory, use:

> getquota

Ouput:

      You're using 8.50 GB of 21.47 GB allowed space.


## Special partition
To check the space in our special space

> df –h /work/omicsbio 

      Filesystem                                              Size  Used Avail Use% Mounted on
      scratch1.oscer.ou.edu:/export/zscratch1/.work/omicsbio  1.0T  993G   32G  97% /work/omicsbio


## Partition properties
If you can to look at your partition's properties, you can use the following command.

>  scontrol show partition partition_name

e.g.

>  scontrol show partition omicsbio

Output:

      PartitionName=omicsbio
      AllowGroups=omicsbio,oscer,wheel,benchmark AllowAccounts=test,default,general,oscer,omicsbio AllowQos=ALL
      AllocNodes=ALL Default=NO QoS=N/A
      DefaultTime=NONE DisableRootJobs=NO ExclusiveUser=NO GraceTime=0 Hidden=NO
      MaxNodes=UNLIMITED MaxTime=UNLIMITED MinNodes=0 LLN=NO MaxCPUsPerNode=44
      Nodes=c[651,657-661]
      PriorityJobFactor=1 PriorityTier=1 RootOnly=NO ReqResv=NO OverSubscribe=NO
      OverTimeLimit=NONE PreemptMode=OFF </br>
      State=UP TotalCPUs=244 TotalNodes=6 SelectTypeParameters=NONE
      JobDefaults=(null)
      DefMemPerNode=UNLIMITED MaxMemPerNode=385300

## Node properties
If you can to look at a specific node's properties, you can use the following command.

>scontrol show node node_name </br>

e.g.

> scontrol show node c657 </br>

Output:

      NodeName=c657 Arch=x86_64 CoresPerSocket=20
      CPUAlloc=0 CPUTot=40 CPULoad=0.01
      AvailableFeatures=(null)
      ActiveFeatures=(null)
      Gres=(null)
      NodeAddr=c657 NodeHostName=c657 Version=20.02.1
      OS=Linux 3.10.0-693.11.6.el7.x86_64 #1 SMP Thu Jan 4 01:06:37 UTC 2018
      RealMemory=191694 AllocMem=0 FreeMem=184194 Sockets=2 Boards=1
      State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=10 Owner=N/A MCS_label=N/A
      Partitions=omicsbio
      BootTime=2019-06-11T18:08:45 SlurmdStartTime=2020-05-05T16:46:44
      CfgTRES=cpu=40,mem=191694M,billing=40
      AllocTRES=
      CapWatts=n/a
      CurrentWatts=0 AveWatts=0 
      ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

## Job properties
If you can to look at a specific job's properties, you can use the following command.
> scontrol show job job_number

e.g.

> scontrol show job 34718261


## Modules available

In order to see the different modules available, use the following commands.

There is a list at [this link](http://www.ou.edu/oscer/resources/hpc_software); however, it is non-updated.

> module avail

Output:

      ------------------------- /opt/oscer/modulefiles/Linux -------------------------
         compilers/intel/16.0      (D)    mpi/openmpi/1.10.1/intel  (D)
         compilers/intel/16.1             mpi/openmpi/1.10.1/pgi
         compilers/intel/16.3             mpi/openmpi/1.10.3/intel
         compilers/pgi/16.1               netcdf/4.2.0/intel/serial
         hdf4/4.2.10/intel         (D)    netcdf/4.4.0/pgi/serial
         hdf4/4.2.10/pgi                  python/anaconda2-oscer
         hdf5/1.8.12/intel/openmpi        python/anaconda2
         hdf5/1.8.12/intel/serial  (D)    python/anaconda2-4.2.0
         hdf5/1.8.16/pgi/serial           python/anaconda3          (D)
         mpi/intel/16.0            (D)    szip/2.1/intel            (D)
         mpi/intel/16.1                   szip/2.1/pgi
         mpi/intel/16.3

      -------------------------- /opt/oscer/modulefiles/all --------------------------
         454DataAnalysis/2.9
         ABAWACA/1.00-foss-2018b
         ABySS/1.5.2-goolf-1.4.10
         ACTC/1.1-GCCcore-6.4.0
         AMOS/3.1.0-goolf-1.4.10
         ANSYS_Workbench/17.2
         ANTLR/2.7.7-intel-2015b-Python-2.7.10
       --More--

## Load module

> module load module_name

e.g.

Running the command `module avail`, we search for python libraries.

      Python/2.7.14-intel-2018a
      Python/2.7.15-foss-2018b
      Python/2.7.15-foss-2019b
      Python/2.7.15-GCCcore-7.3.0-bare
      Python/2.7.15-GCCcore-8.2.0
      Python/2.7.16-GCCcore-8.3.0
      Python/2.7.18-GCCcore-9.3.0
      Python/3.5.1-intel-2016a
      Python/3.6.3-intel-2016a
      Python/3.6.4-foss-2017b
      Python/3.6.4-foss-2018a
      Python/3.6.4-intel-2018a
      Python/3.6.6-foss-2018b
      Python/3.7.4-GCCcore-8.3.0
      Python/3.7.6-foss-2019a
      Python/3.8.0-GCCcore-8.2.0
      Python/3.8.2-GCCcore-9.3.0                                    (D)

e.g.
> module load Python/3.8.0-GCCcore-8.2.0

If the version-variant is not specified the default one is loaded (indicated with a **(D)**)

> module load Python

is equivalent to:

> module load Python/3.8.2-GCCcore-9.3.0 

## List of modules

In order to know the loaded modules, run:

> module list

## Usage of nodes in partition

> sinfo -p parition_name -O nodehost,cpusload,freemem

e.g.

> sinfo -p omicsbio -O nodehost,cpusload,freemem

Output:

      HOSTNAMES           CPU_LOAD            FREE_MEM
      c651                0.03                374721
      c658                0.01                57372
      c661                0.98                64843
      c657                0.01                185748
      c659                0.01                186231
      c660                0.02                182630

> sinfo -p disc  -O nodehost,cpusstate,freemem,allocmem,memory,Gres,GresUsed


Output:

      HOSTNAMES           CPUS(A/I/O/T)       FREE_MEM            ALLOCMEM            MEMORY              GRES                GRES_USED
      c849                64/64/0/128         412706              11000               515133              gpu:H100:2          gpu:H100:2(IDX:0-1)
      c850                64/64/0/128         408037              11000               515133              gpu:H100:2          gpu:H100:2(IDX:0-1)
      c851                64/64/0/128         350724              11000               515133              gpu:H100:2          gpu:H100:2(IDX:0-1)
      c852                64/64/0/128         368991              11000               515133              gpu:H100:2          gpu:H100:2(IDX:0-1)
      c862                64/64/0/128         384052              11000               515133              gpu:A100:2          gpu:A100:2(IDX:0-1)
      c863                64/64/0/128         365054              11000               515133              gpu:A100:2          gpu:A100:2(IDX:0-1)
      c864                64/64/0/128         355275              11000               515133              gpu:A100:2          gpu:A100:2(IDX:0-1)
      c865                64/64/0/128         359428              11000               515133              gpu:A100:2          gpu:A100:2(IDX:0-1)
      c866                16/112/0/128        303203              250000              515133              gpu:A100:2          gpu:A100:2(IDX:0-1)
      c856                128/0/0/128         898927              22000               1031541             gpu:A100:4          gpu:A100:4(IDX:0-3)
      c915                0/128/0/128         2046847             0                   2063324             (null)              gpu:0
      c916                0/128/0/128         2047942             0                   2063324             (null)              gpu:0


