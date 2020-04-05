## DockerServer & AnsibleServer: Docker rm
docker rm -f $(docker ps -a -q)
docker rmi $(docker images -a -q)

## AnsibleServer: Hosts
```
su - ansadmin
cd /opt/docker
vim hosts
"""
localhost
IPprivateserverdocker
"""
```

## AnsibleServer: Playbook
```
ansible-playbook -i hosts create-simple-devops-project.yml --limit localhost
ansible-playbook -i hosts create-simple-devops-project.yml --limit IPprivateserverdocker
```
* run: ansible-playbook -i hosts create-simple-devops-project.yml --limit IPprivateserverdocker
1) error:
```
TASK [Gathering Facts] 
fatal: [172.31.44.192]: FAILED! => {"msg": "Missing sudo password"}
```
2) solution:
```
# dockerserver
visudo
"""
ansadmin ALL=(ALL) NOPASSWD: ALL
"""
```

## DockerServer: Check DockerContainer and DockerImage
```
docker ps -a
docker images
```
* IPserverdocker:8080/webapp