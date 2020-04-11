## K8sServer: Delete Deployment and Service
```
kubectl delete deployment edy-deployment
kubectl delete service edy-service
```

## JenkinsServer: NewJob
- New Item
	- name: deploy_on_kubernetes_CD
	- Freestyle project
- Post-build Actions > Send build artifacts over SSH > SSH Publishers
	- Name: [ansible-server](class9_Integrate-Ansible-with-jenkins.md)
	- Exec command: 
```
ansible-playbook -i /opt/kubernetes/hosts /opt/kubernetes/kubernetes-edy-deployment.yml;
ansible-playbook -i /opt/kubernetes/hosts /opt/kubernetes/kubernetes-edy-service.yml
```
- Build Now