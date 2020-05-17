# Slurm basics

## Work folder PANlab in schooner 
> cd /work/omicsbio/

## Information of partition
> sinfo -p omicsbio

-p: partition

if -p is not specified (i.e. _sinfo_), all partitions nodes are shown

OUTPUT: 

      PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST <br> 
      omicsbio     up   infinite      2    mix c[658,661] <br>
      omicsbio     up   infinite      4   idle c[651,657,659-660]




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

-p: partition <br>

Output:

      JOBID  PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) 
      28204348  omicsbio       ko lizhang1  R 1-13:17:11      1 c657 </br>
      28000091  omicsbio jupyter-  adbadre  R 10-00:09:16      1 c660 </br>
      27996452  omicsbio jupyter-  adbadre  R 10-04:47:54      1 c659 </br>

> squeue -u adbadre

-u: user

Output:

      JOBID  PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) 
      28000091  omicsbio jupyter-  adbadre  R 10-00:09:16      1 c660 </br>
      27996452  omicsbio jupyter-  adbadre  R 10-04:47:54      1 c659 </br>

If -p nor u is specified, it shows all jobs in all partitions

## Cancel jobs

> scancel jobid <br>

e.g. <br>
> scancel 28204348


## Get Information

### Partition

>  scontrol show partition omicsbio

>>  PartitionName=omicsbio
   AllowGroups=omicsbio,oscer,wheel,benchmark AllowAccounts=test,default,general,oscer,omicsbio AllowQos=ALL </br>
   AllocNodes=ALL Default=NO QoS=N/A </br>
   DefaultTime=NONE DisableRootJobs=NO ExclusiveUser=NO GraceTime=0 Hidden=NO </br>
   MaxNodes=UNLIMITED MaxTime=UNLIMITED MinNodes=0 LLN=NO MaxCPUsPerNode=44
   Nodes=c[651,657-661] </br>
   PriorityJobFactor=1 PriorityTier=1 RootOnly=NO ReqResv=NO OverSubscribe=NO </br>
   OverTimeLimit=NONE PreemptMode=OFF </br>
   State=UP TotalCPUs=244 TotalNodes=6 SelectTypeParameters=NONE
   JobDefaults=(null) </br>
   DefMemPerNode=UNLIMITED MaxMemPerNode=385300

### Node

>scontrol show node c651 </br>
>>NodeName=c651 Arch=x86_64 CoresPerSocket=22 </br>
   CPUAlloc=1 CPUTot=44 CPULoad=1.02 </br>
   AvailableFeatures=(null) </br>
   ActiveFeatures=(null) </br>
   Gres=(null) </br>
   NodeAddr=c651 NodeHostName=c651 Version=20.02.1 </br>
   OS=Linux 3.10.0-693.11.6.el7.x86_64 #1 SMP Thu Jan 4 01:06:37 UTC 2018 </br>
   RealMemory=385300 AllocMem=61440 FreeMem=358601 Sockets=2 Boards=1 </br>
   State=MIXED ThreadsPerCore=1 TmpDisk=0 Weight=10 Owner=N/A MCS_label=N/A </br>
   Partitions=omicsbio </br>
   BootTime=2020-02-07T10:53:29 SlurmdStartTime=2020-05-05T16:49:01 </br>
   CfgTRES=cpu=44,mem=385300M,billing=44 </br>
   AllocTRES=cpu=1,mem=60G </br>
   CapWatts=n/a </br>
   CurrentWatts=0 AveWatts=0 </br>
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s </br>
 
> scontrol show node c657 </br>
>> NodeName=c657 Arch=x86_64 CoresPerSocket=20 </br>
   CPUAlloc=0 CPUTot=40 CPULoad=0.01 </br>
   AvailableFeatures=(null) </br>
   ActiveFeatures=(null) </br>
   Gres=(null) </br>
   NodeAddr=c657 NodeHostName=c657 Version=20.02.1 </br>
   OS=Linux 3.10.0-693.11.6.el7.x86_64 #1 SMP Thu Jan 4 01:06:37 UTC 2018 </br>
   RealMemory=191694 AllocMem=0 FreeMem=184194 Sockets=2 Boards=1 </br>
   State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=10 Owner=N/A MCS_label=N/A
   Partitions=omicsbio </br>
   BootTime=2019-06-11T18:08:45 SlurmdStartTime=2020-05-05T16:46:44 </br>
   CfgTRES=cpu=40,mem=191694M,billing=40 </br>
   AllocTRES= </br>
   CapWatts=n/a</br>
   CurrentWatts=0 AveWatts=0 </br>
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s </br>