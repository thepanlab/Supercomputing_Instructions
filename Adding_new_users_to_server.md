# Adding a new user to a linux server
  
Note, sudo privileges are needed in order to be able to add users. 

If needing to specify a shell type and/or groups for the new user:

```
sudo useradd -m -s /bin/bash -G [group1,group2,...] username
```

If shell and groups don't need to be specified for the new user:

```
sudo useradd -m username
```

e.g.

- Description of options:
    - `-m`: Creates the user's home directory, if it doesn't exist.
    - `-s /bin/bash`: Specifies the user's default shell.
    - `-G [group1,group2,...]`: Adds the user to the specified groups.
    - For thunder, laker and blazer, no need to specify default shell or group. 

Then set a temporary password for the new user:

```
sudo passwd username
```

- enter a temporary password such as *changeMeNow*

Then, expire that password:

```
sudo passwd -e username
```
- The '-e' flag stands for "expire" and when this option is used the user will be prompted to change their password the next time they log in. 

In order to specify the shell bash:
```
sudo usermod --shell /bin/bash username
```
