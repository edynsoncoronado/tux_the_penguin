## AnsibleServer: Docker rm
```
docker rm -f simple-devops-conatiner
docker rmi simple-devops-image:latest tomcat:8.0
```

## AnsibleServer: Edit playbook
```
vim simple-devops-project.yml
"""
---
- hosts: all
  become: true
  tasks:
  - name: stop current running container
    command: docker stop simple-devops-container
    ignore_errors: yes

  - name: remove stopped container
    command: docker rm simple-devops-container
    ignore_errors: yes

  - name: remove docker image
    command: docker rmi simple-devops-image
    ignore_errors: yes

  - name: building docker image
    command: docker build -t simple-devops-image .
    args:
        chdir: /opt/docker

  - name: create container using simple-devops-image
    command: docker run -d --name simple-devops-container -p 8080:8080 simple-devops-image
"""
```

## JenkinsServer: Using Job [Deploy_on_Container_using_ansible](class9_Integrate-Ansible-with-jenkins.md)
1) Configure > Post-build Actions > SSH Publishers > Transfers > Exec command:
	- ansible-playbook -i /opt/docker/hosts /opt/docker/simple-devops-project.yml;

2) Build Triggers > check Poll SCM:
	- \* * * * *

## JenkinsServer: Build Now or Modify repo hello-world
```
vim hello-world/webapp/src/main/webapp/index.jsp
"""
<h2> Deploying on Container</h2>
"""
git add
git commit
git push origin master
```
* IPAnsibleServer:8080/webapp/
