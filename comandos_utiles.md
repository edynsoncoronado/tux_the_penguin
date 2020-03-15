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
