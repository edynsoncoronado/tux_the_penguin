## RESIZE NITRO
### IDENTIFICAR SISTEMA DE ARCHIVOS
```bash
sudo file -s /dev/nvme?n*
```
### AMPLIAR PARTICIÓN
```bash
lsblk
sudo growpart /dev/nvme0n1 1
lsblk
```

## RESIZE T2
### IDENTIFICAR SISTEMA DE ARCHIVOS
```bash
sudo file -s /dev/xvd*
```
### AMPLIAR PARTICIÓN
```bash
lsblk
sudo growpart /dev/xvda 1
sudo growpart /dev/xvdf 1
lsblk
```

## AMPLIACIÓN DEL SISTEMA DE ARCHIVOS
### FORMAT ext2, ext3 o ext4
```bash
df -h
# opción1
sudo resize2fs /dev/xvda1
# opción2
sudo resize2fs /dev/nvme0n1p1
df -h
```

### FORMAT XFS
```bash
df -h
sudo yum install xfsprogs
sudo xfs_growfs -d /
sudo xfs_growfs -d /data
df -h
```

Fuente: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html
