## Files YAML
```
cat > edy-service.yml
"""
apiVersion: v1
kind: Service
metadata:
  name: edy-service
  labels:
    app: edynson-devops-project
spec:
  selector:
    app: edynson-devops-project
  type: LoadBalancer
  ports:
    - port: 8080
      targetPort: 8080
      nodePort: 31200
"""
cat > edy-deploy.yml
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

## Delete Deployment Nginx
```
kubectl delete deployment sample-nginx
kubectl delete service sample-nginx
```

## Deploying Container and Expose as Service
```
kubectl apply -f edy-deploy.yml
kubectl get deployments
kubectl apply -f edy-service.yml
kubectl get services
>>>
NAME          TYPE           CLUSTER-IP     EXTERNAL-IP                                                               PORT(S)          AGE
edy-service   LoadBalancer   100.67.18.37   afd6bb3f7d27e4f98b5f520809ce6d9b-1699418507.us-east-1.elb.amazonaws.com   8080:31200/TCP   3m3s
kubernetes    ClusterIP      100.64.0.1     <none>                                                                    443/TCP          6h
<<<
```
- Open Browser:  
	Public DNS (IPv4):31200
