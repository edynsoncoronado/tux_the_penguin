## AnsibleServer: Push DockerImage
```
sudo mv Dockerfile create-simple-devops-image.yml /opt/kubernetes/
sudo vim create-simple-devops-image.yml
"""
- hosts: ansible-server
  become: true
  tasks:
  - name: create docker image using war file
    command: docker build -t simple-devops-image:latest .
    args:
        chdir: /opt/kubernetes

  - name: create tag to image
    command: docker tag simple-devops-image edynson/simple-devops-image

  - name: push image on to dockerhub
    command: docker push edynson/simple-devops-image

  - name: remove docker images form ansible server
    command: docker rmi simple-devops-image:latest edynson/simple-devops-image
    ignore_errors: yes
"""
sudo chown -R ansadmin:ansadmin /opt/kubernetes
```

## JenkinsServer: NewJob
- New Item
	- name: deploy_on_Kubernetes_CI
	- copy: Deploy_on_Docker_Container_using_Ansible_playbooks
- Post-build Actions > Send build artifacts over SSH > 	SSH Publishers > Transfers
	- Remote directory: //opt//kubernetes
	- Exec command: ansible-playbook -i /opt/kubernetes/hosts /opt/kubernetes/create-simple-devops-image.yml;