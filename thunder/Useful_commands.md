# How to select GPU
If you want to specify the GPU(s)

> CUDA_VISIBLE_DEVICES=0,1 python script.py <br>

e.g. <br>

> CUDA_VISIBLE_DEVICES=1 python script.py <br>

From [link.]([Link](https://stackoverflow.com/questions/40069883/how-to-set-specific-gpu-in-tensorflow))

# See information GPU cards
> nvidia-smi <br>
> watch -n 1 nvidia-smi

# Information about process
> ps -p 1615667 -f