## Launch Instance
- AMI: Ubuntu Server 18.04 LTS
- Instance Type: t2.micro
- SG ports: 22;8080

## AnsibleServer: Install Ansible
```
sudo apt install python3-pip -y
sudo pip3 install ansible
# ansible --version
sudo mkdir /etc/ansible
sudo useradd -m -U -s /bin/bash ansadmin
sudo passwd ansadmin
echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```
** You chan change edit /etc/sudoers by:
```
sudo visudo
```

## AnsibleServer: Install Docker
```
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ansadmin
```

## AnsibleServer: SSH Config
```
vim /etc/ssh/sshd_config
"""
PasswordAuthentication yes
"""
service sshd reload
su - ansadmin
ssh-keygen
```

## DockerServer: Create User
```
sudo useradd -m -U -s /bin/bash ansadmin
sudo passwd ansadmin
```

## AnsibleServer: SSH Copy
```
su - ansadmin
ssh-copy-id ansadmin@IPprivatedockerserver
ssh-copy-id localhost
```

## AnsibleServer: Config Host
```
cd /etc/ansible
sudo vim hosts
"""
IPprivatedockerserver
localhost
"""
su - ansadmin
ansible all -m ping
```