
# A quick script to launch jupyter from thunder

echo "



From a new local terminal

lsof -ti:8888 | xargs kill -9
ssh -N -f -L 8888:localhost:8888 jreynolds@thunder.cs.nor.ou.edu

-- enter password

Now open a new chrome window and navigate to
http://localhost:8888/

If necessary, copy and paste the token provided by the 
console log below for verification. 

"
jupyter lab --no-browser --port=8888
