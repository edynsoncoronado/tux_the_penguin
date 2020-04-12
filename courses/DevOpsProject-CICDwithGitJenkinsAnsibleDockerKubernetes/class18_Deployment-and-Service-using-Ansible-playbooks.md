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
sudo vim kubernetes-edy-deployment.yml
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
sudo vim kubernetes-edy-service.yml
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

## K8sClusterMaster: Delete Deployment and Service
```
kubectl delete deployment edy-deployment
kubectl delete service edy-service
```

## AnsibleServer: Running ansilbe playbooks
```
su - ansadmin 
cd /opt/kubernetes
ansible-playbook -i hosts kubernetes-edy-deployment.yml
ansible-playbook -i hosts kubernetes-edy-service.yml
```
- Open Browser:  
	K8sClusterMaster:Public DNS (IPv4):31200