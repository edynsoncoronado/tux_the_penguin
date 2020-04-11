## Copy public key onto Kubernetes cluster master
- AnsibleServer
```
su - ansadmin 
cat ~/.ssh/id_rsa.pub
```

- Kubernetes cluster master
```
cat >> /home/admin/.ssh/authorized_keys
```

- AnsibleServer
```
ssh -i ~/.ssh/id_rsa admin@IPkubernetesServer
```

## AnsibleServer: Update hosts file with new group called kubernetes
```
sudo mkdir /opt/kubernetes
sudo vim /opt/kubernetes/hosts
"""
[ansible-server]
localhost

[kubernetes]
IPkubernetesServer
"""
```

### AnsibleServer: Create ansible playbooks to create deployment and services
```
cd /opt/kubernetes
vim kubernetes-edy-deployment.yml
"""
---
- name: Create pods using deployment 
  hosts: kubernetes 
  become: true
  user: admin
 
  tasks: 
  - name: create a deployment
    command: kubectl apply -f edy-deploy.yml
"""
vim kubernetes-edy-service.yml
"""
---
- name: create service for deployment
  hosts: kubernetes
  become: true
  user: admin

  tasks:
  - name: create a service
    command: kubectl apply -f edy-service.yml
"""
```