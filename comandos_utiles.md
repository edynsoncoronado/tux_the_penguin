### CPU Info:
$ cat /proc/cpuinfo | grep processor | wc -l
$ lscpu
$ nproc

### Monitorizar ram:
$ free -h

### Ps AUX
ps aux | grep apache

### Liberar memoria swap
swapoff -a && swapon -a

### Create default home directory for existing user in terminal
mkhomedir_helper username

### ssh keygen
ssh-keygen -t rsa -b 4096
