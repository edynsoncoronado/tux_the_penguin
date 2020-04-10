## SSH Connect Kubernetes Master
```
ssh -i ~/.ssh/id_rsa admin@api.demo.k8s.edynsoncoronado.com
```
* Other commands:
```
kubectl get nodes
kubectl get pods
kubectl get deploy
kubectl get service
```

## Deploying Nginx Container
```
kubectl run sample-nginx --image=nginx --replicas=2 --port=80
kubectl get deployment
kubectl get pods
kubectl get pods -o wide
```

## Expose the deployment as service
	- This will create an ELB in front of those 2 containers and allow us to publicly access them.
```
kubectl expose deployment sample-nginx --port=80 --type=LoadBalancer
kubectl get services
>>>
NAME           TYPE           CLUSTER-IP     EXTERNAL-IP                                                               PORT(S)        AGE
kubernetes     ClusterIP      100.64.0.1     <none>                                                                    443/TCP        49m
sample-nginx   LoadBalancer   100.64.53.77   ad1b95d43feef4ea895557407614eda0-1455974444.us-east-1.elb.amazonaws.com   80:30782/TCP   69s
```
	- Welcome to nginx! Open Browser:
		**Public DNS (IPv4):30782


## Checking Availability
```
kubectl get pods -o wide
>>>>
NAME                            READY   STATUS    RESTARTS   AGE   IP           NODE                           NOMINATED NODE   READINESS GATES
sample-nginx-857ffdb4f4-7b44g   1/1     Running   0          24m   100.96.1.5   ip-172-20-58-76.ec2.internal   <none>           <none>
sample-nginx-857ffdb4f4-mzhkd   1/1     Running   0          24m   100.96.2.2   ip-172-20-49-89.ec2.internal   <none>           <none>
<<<<
kubectl delete pod sample-nginx-857ffdb4f4-mzhkd sample-nginx-857ffdb4f4-7b44g
kubectl get pods -o wide
>>>>
NAME                            READY   STATUS    RESTARTS   AGE   IP           NODE                           NOMINATED NODE   READINESS GATES
sample-nginx-857ffdb4f4-kw86w   1/1     Running   0          13s   100.96.2.4   ip-172-20-49-89.ec2.internal   <none>           <none>
sample-nginx-857ffdb4f4-ntlz5   1/1     Running   0          13s   100.96.2.3   ip-172-20-49-89.ec2.internal   <none>           <none>
<<<<
```