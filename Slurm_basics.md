# Slurm basics

## Work folder PANlab in schooner 
> cd /work/omicsbio/

## Information of partition
> sinfo -p omicsbio

Output: 

      PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST  
      omicsbio     up   infinite      2    mix c[658,661] 
      omicsbio     up   infinite      4   idle c[651,657,659-660]
-p: partition

if -p is not specified (i.e. _sinfo_), all partitions nodes are shown

## Table of nodes in schooner:

|Node| # Processors| # Sockets | Memory |
|---|---|---|---|
|**c651**| **44** | 2 | **400GB**|  
|c657| 40 | 2 | 200GB|
|c658| 40 | 2 | 200GB|
|c659| 40 | 2 | 200GB|
|c660| 40 | 2 | 200GB|
|c661| 40 | 2 | 200GB|

## Jobs in partition

> squeue -p omicsbio

Output:

         JOBID PARTITION     NAME     USER ST        TIME  NODES NODELIST(REASON) 
      28204348  omicsbio       ko lizhang1  R  1-13:17:11      1 c657
      28000091  omicsbio jupyter-  adbadre  R 10-00:09:16      1 c660
      27996452  omicsbio jupyter-  adbadre  R 10-04:47:54      1 c659

-p: partition <br>


> squeue -u adbadre

-u: user

Output:

         JOBID  PARTITION     NAME     USER ST        TIME  NODES NODELIST(REASON) 
      28000091   omicsbio jupyter-  adbadre  R 10-00:09:16      1 c660
      27996452   omicsbio jupyter-  adbadre  R 10-04:47:54      1 c659

If -p nor u is specified, it shows all jobs in all partitions

## Cancel jobs

> scancel jobid <br>

e.g. <br>
> scancel 28204348


## Get Information

### Partition

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

### Node

>scontrol show node c651 </br>

Output:

      NodeName=c651 Arch=x86_64 CoresPerSocket=22
      CPUAlloc=1 CPUTot=44 CPULoad=1.02
      AvailableFeatures=(null)
      ActiveFeatures=(null)
      Gres=(null)
      NodeAddr=c651 NodeHostName=c651 Version=20.02.1
      OS=Linux 3.10.0-693.11.6.el7.x86_64 #1 SMP Thu Jan 4 01:06:37 UTC 2018
      RealMemory=385300 AllocMem=61440 FreeMem=358601 Sockets=2 Boards=1
      State=MIXED ThreadsPerCore=1 TmpDisk=0 Weight=10 Owner=N/A MCS_label=N/A
      Partitions=omicsbio
      BootTime=2020-02-07T10:53:29 SlurmdStartTime=2020-05-05T16:49:01
      CfgTRES=cpu=44,mem=385300M,billing=44
      AllocTRES=cpu=1,mem=60G
      CapWatts=n/a
      CurrentWatts=0 AveWatts=0
      ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s
 
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
## Module availables

In order to see the different modules available, use the following commands.

This [link](http://www.ou.edu/oscer/resources/hpc_software) contains a non-updated list.

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

Running the command *module avail*, we search for python libraries.

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

In order to know the loaded module, run:

> module list