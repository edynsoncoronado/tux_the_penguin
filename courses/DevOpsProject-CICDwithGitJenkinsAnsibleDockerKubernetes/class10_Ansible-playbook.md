## AnsibleServer: Create Dockerfile
```
su - ansadmin
cd /op/docker
vim Dockerfile
"""
FROM tomcat:8.0

COPY ./webapp.war /usr/local/tomcat/webapps
"""
vim simple-devops-image.yml
"""
- hosts: all
  become: true
  tasks:
  - name: building docker image
    command: docker build -t simple-devops-image .
    args:
      chdir: /opt/docker
"""
```
## AnsibleServer: Create Playbook
```
pwd
>>> /opt/docker
vim simple-devops-project.yml
"""
---
- hosts: all
  become: true
  tasks:
  - name: building docker image
    command: docker build -t simple-devops-image .
    args:
      chdir: /opt/docker

  - name: create container using simple-devops-image
    command: docker run -d --name simple-devops-container -p 8080:8080 simple-devops-image
"""
```

## AnsibleServer: Hosts
```
vim hosts
"""
localhost
"""
ls
>>> Dockerfile hosts simple-devops-image.yml webapp.war
```

## AnsibleServer: Check and Run Playbook
```
ansible-playbook -i hosts simple-devops-image.yml --check
ansible-playbook -i hosts simple-devops-image.yml
```

## AnsibleServer: DockerImages
```
docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
simple-devops-image   latest              d27f2dc6febc        26 seconds ago      356MB
tomcat                8.0                 ef6a7c98d192        18 months ago       356MB

docker ps
CONTAINER ID        IMAGE                 COMMAND             CREATED              STATUS              PORTS                    NAMES
ab3beaa0dedc        simple-devops-image   "catalina.sh run"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp   simple-devops-conatiner
```