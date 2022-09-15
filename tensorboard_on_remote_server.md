# Tensorboard

09/15/2022
Justin Reynolds

Running Tensorboard on remote server to visualize training and validation progress...

https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server

- Create a file writer that saves loss and accuracy in a directory named `logs` during training, such as:

```
import tensorflow as tf

...

train_log_dir = os.path.join('logs', '{}_{}_{}_train'.format(now, dataset_str, tag))
train_summary_writer = tf.summary.create_file_writer(train_log_dir)

... training ...

with train_summary_writer.as_default():
    tf.summary.scalar('loss', tf.reduce_mean(train_loss), step=epoch)
    tf.summary.scalar('acc', tf.reduce_mean(train_loss), step=epoch)

with val_summary_writer.as_default():
    tf.summary.scalar('val_loss', tf.reduce_mean(val_loss), step=epoch)
    tf.summary.scalar('val_acc', tf.reduce_mean(val_acc), step=epoch)
```
    
- From the terminal on local machine:

    `ssh -L 16006:127.0.0.1:8895 jreynolds@laker.cs.nor.ou.edu`
    
    - Can also use the following to push ssh in the background (-f) and use no remote commands (-N)
        
        `ssh -N -f -L localhost:16006:localhost:8895 jreynolds@laker.cs.nor.ou.edu`
        
- After logging in, from the remote machine, activate a conda env that has tensorboard installed via tensorflow: 

    `conda activate tf0`

- And, from the remote machine: 

    `tensorboard --logdir <path_to_logs_dir> --port 8895`

- Lastly, in a web browser: 

    `127.0.0.1:16006`

    - Note: don't precede the url with `http` nor use `localhost` in place of `127.0.0.1`. 