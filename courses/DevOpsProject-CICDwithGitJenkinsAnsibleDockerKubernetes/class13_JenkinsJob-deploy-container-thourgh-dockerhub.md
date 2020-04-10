## DockerServer & AnsibleServer: Docker rm
```
docker rm -f $(docker ps -a -q)
docker rmi $(docker images -a -q)
```

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

## JenkinsServer: Copy Job
1) New Item:
	- name: Deploy_on_Docker_Container_using_Ansible_playbooks
	- copy from: Deploy_on_Container_using_ansible
2) Post-build Actions > SSH Publishers > Transfers > Exec command:
```
ansible-playbook -i /opt/docker/hosts /opt/docker/create-simple-devops-project.yml --limit localhost;
ansible-playbook -i /opt/docker/hosts /opt/docker/create-simple-devops-project.yml --limit IPprivatedockerserver
```
3) Modify repo [helloworld](https://github.com/edynsoncoronado/hello-world)
```
vim hello-world/webapp/src/main/webapp/index.jsp
git commit
git add
git push
```
* IPserverdocker:8080
