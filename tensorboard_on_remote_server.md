# Tensorboard

09/15/2022
Justin Reynolds

Running Tensorboard on remote server to visualize training and validation progress...

https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server

- Create a file writer that saves loss and accuracy in a directory named `logs` during training, such as:

```python
import tensorflow as tf

...

train_log_dir = os.path.join('logs', '{}_{}_{}_train'.format(now, dataset_str, tag))
train_summary_writer = tf.summary.create_file_writer(train_log_dir)

# ... training ...

with train_summary_writer.as_default():
    tf.summary.scalar('loss', tf.reduce_mean(train_loss), step=epoch)
    tf.summary.scalar('acc', tf.reduce_mean(train_loss), step=epoch)

with val_summary_writer.as_default():
    tf.summary.scalar('val_loss', tf.reduce_mean(val_loss), step=epoch)
    tf.summary.scalar('val_acc', tf.reduce_mean(val_acc), step=epoch)
```

If using Keras. [Source](https://www.tensorflow.org/tensorboard/get_started#using_tensorboard_with_keras_modelfit):
```python
model = create_model()
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)

model.fit(x=x_train, 
          y=y_train, 
          epochs=5, 
          validation_data=(x_test, y_test), 
          callbacks=[tensorboard_callback])
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
