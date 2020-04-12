## K8sClusterMaster: Update edy-deploy.yml
```
vim /home/admin/edy-deploy.yml
"""
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: edy-deployment
spec:
  selector:
    matchLabels:
      app: edynson-devops-project
  replicas: 2 # tells deployment to run 2 pods matching the template
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1

  template:
    metadata:
      labels:
        app: edynson-devops-project
    spec:
      containers:
      - name: edynson-devops-project
        image: edynson/simple-devops-image
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
"""
```

## AnsibleServer: Update
```
su - ansadmin
vim /opt/kubernetes/kubernetes-edy-deployment.yml
"""
---
- name: Create pods using deployment 
  hosts: kubernetes 
  become: true
  user: admin
 
  tasks: 
  - name: create a deployment
    command: kubectl apply -f edy-deploy.yml

  - name: update deployment with new pods if image updated in docker hub
    command: kubectl rollout restart deployment.v1.apps/edy-deployment
"""
```

## Integrating Jenkins CI CD jobs
	- Update Job: deploy_on_Kubernetes_CI
	- Post-build Actions > add post-build action > Build other projects
		- Projects to build: deploy_on_kubernetes_CD
		- check Trigger only if build is stable