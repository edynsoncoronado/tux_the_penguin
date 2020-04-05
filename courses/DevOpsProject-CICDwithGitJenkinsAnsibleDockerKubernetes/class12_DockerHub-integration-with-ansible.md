## AnsibleServer: DockerHub push
```
docker tag simple-devops-image edynson/simple-devops-image
docker login
docker push edynson/simple-devops-image
```

## DockerServer: DockerHub pull
```
su - dockeradmin
docker pull edynson/simple-devops-image
```
* User dockeradmin in group docker
	- id
* if dockeradmin not in group docker
	- usermod -aG docker dockeradmin

## AnsibleServer: Playbook Create Image
```
su - ansadmin
cd /op/docker
vim create-simple-devops-image.yml
"""
---
- hosts: all
  become: true
  tasks:
  - name: create docker image using war file
    command: docker build -t simple-devops-image:latest .
    args:
        chdir: /opt/docker

  - name: create tag to image
    command: docker tag simple-devops-image edynson/simple-devops-image

  - name: push image on to dockerhub
    command: docker push edynson/simple-devops-image

  - name: remove docker images form ansible server
    command: docker rmi simple-devops-image:latest edynson/simple-devops-image
    ignore_errors: yes
"""
docker rm -f $(docker ps -a -q)
docker rmi $(docker images -a -q)
ansible-playbook -i hosts create-simple-devops-image.yml
```
* run: ansible-playbook -i hosts cr...
1) error 
```
fatal: [localhost]: FAILED! => {"changed": true, "cmd": ["docker", "push", "edynson/simple-devops-image"], "delta": "0:00:00.262137", "end": "2020-04-04 20:04:39.446893", "msg": "non-zero ret$
rn code", "rc": 1, "start": "2020-04-04 20:04:39.184756", "stderr": "denied: requested access to the resource is denied",
```
2) solution
```
sudo su
docker login
```

## AnsibleServer: Playbook Create Container
```
vim create-simple-devops-project.yml
"""
---
- hosts: all
  become: true
  tasks:
  - name: stop current running container
    command: docker stop simple-devops-container
    ignore_errors: yes

  - name: remove stopped container
    command: docker rm simple-devops-container:latest
    ignore_errors: yes

  - name: remove docker image
    command: docker rmi edynson/simple-devops-image:latest
    ignore_errors: yes

  - name: pull docker image from dockerhub
    command: docker pull edynson/simple-devops-image:latest

  - name: create container using simple-devops-image
    command: docker run -d --name simple-devops-container -p 8080:8080 edynson/simple-devops-image:latest
"""
ansible-playbook -i hosts create-simple-devops-project.yml
```