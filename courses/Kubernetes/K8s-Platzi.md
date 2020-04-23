## ¿Qué es kubernetes? 
- Una herramienta open source de orquestación de contenedores.
- K8s es la plataforma más extensiva para orquestación de servicios e infraestructura.
- *Kubernetes es un concepto abstracto que combina principalmente 3 tecnologías:*
	- **Cgroups - control groups**
		- Aísla los recursos de memoria, IO, CPU.
		- Limita los recursos a usar del sistema operativo.
	- **Namespaces**
		- Hace que nuestra aplicación corra en un sandbox.
		- **Mount namespaces**
			- Hace que nuestra aplicación tenga una visibilidad reducida de las carpetas donde trabaja.
		- **Networking Namespaces**
			- Es la entidad sobre la cual se corre los contenedores.
			- Hace que cada contenedor tenga su interfaz de red, dirección de ip, dirección de rutas.
		- **PID**
			- Es el proceso ejecutado en nuestro contenedor.
	- **Chroot**
		- Permite que nuestro proceso tenga acceso a los recursos del sistema.
		- Cambia el root directory de un proceso.

## Arquitectura de Kubernetes
### Master
- **kube-apiserver**
	- Expone la api de kubernetes.
	- Es la interfaz que sirve como medio de comunicación entre los agentes, CLI o el dashboardy el nodo master.
	- Se usa el algoritmo de raft para algoritmo deelección. https://raft.github.io/
- **kube-scheduler**
	- Se encarga de revisar las restricciones y recursos disponibles al crear un job, un pod en máquinas específicas.
- **kube-controller-manager**
	- Es un proceso que estàn en un ciclo de reconciliación constante buscando llegar al estado deseado con base al modelo declarativo con el que se le dan instrucciones a K8s.
	- Tipos:
		- Replica manager
		- Deployment manager
		- Service manager
- **cloud-controller-manager**
	- Permite que el código de proveedores en la nube y el código de kubernetes evolucionen de forma independiente entre sí.
- **etcd**
	- Key value store que permite que el cluster estealtamente disponible.
	- Utilizado como almacén de respaldo de kubernetes para todos los datos del clúster.
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/arquitecturak81.png)

### Nodo
- **Kubelet**  
	- Agente de kubernetes  
	- Se comunica con el control play y pregunta qué recursos (pods, contenedores) debe correr.  
	- Monitorea los pods constantemente para saber si están vivos, los recursos disponibles.  
- **Kube-proxy**  
	- Se encarga de balancear el tráfico de red que corre en nuestros contenedores/servicios  
	- Una vez llega un request se encarga de decidir a qué pod y contenedor debe ir.  
- **Container Runtime**  
	- Kubernetes admite varios tipos de ejecución:  
		- Docker  
		- Containerd  
		- Cri-o  
		- Rktlet  
		- Cualquier implementación del CRI de Kubernetes  
- **Nodo == Minions**  
	- Todos los nodos y master están conectados a una red física para poder hablarse entre sí.  
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/arquitecturak82.png)

## ¿Qué es un pod?
- Es la unidad básica de ejecución de una aplicación en K8s.
- Representa al proceso en ejecución en el cluster.
- Encapsula un contenedor de aplicaciones o en algunos casos, múltiples contenedores.  
Pueden ser usados de dos maneras:
- **Pods que ejecutan un contenedor:**
	- En este caso un pod es representado como una envoltura de un contenedor (Pod as a wrapper around a single container).
- **Pods que ejecutan múltiples contenedores que necesitan trabajar juntos:**
	- El Pod encampsula una aplicación compuesta de múltiples contenedores acoplados que necesitan compartir recursos.

```
$ kubectl get pods -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP           NODE                            NOMINATED NODE   READINESS GATES
hasher-99d4fdc78-zrm8w    1/1     Running   0          39m   100.96.2.2   ip-172-20-42-96.ec2.internal    <none>           <none>
redis-65fd448c9b-x49cx    1/1     Running   0          40m   100.96.3.2   ip-172-20-38-175.ec2.internal   <none>           <none>
rng-6979b4858b-7gf9v      1/1     Running   0          39m   100.96.5.2   ip-172-20-51-58.ec2.internal    <none>           <none>
webui-97d9f77cf-sfxhd     1/1     Running   0          39m   100.96.4.2   ip-172-20-60-43.ec2.internal    <none>           <none>
worker-598788db65-jcdj9   1/1     Running   0          39m   100.96.5.3   ip-172-20-51-58.ec2.internal    <none>           <none>

```

## Recursos de kubernetes
- https://kubernetes.io/docs/reference/kubectl/overview/#resource-types
- Identifica a un recurso unívocamente:
	- namespace, tipo y nombre.
- Listar
	- kubectl get all --all-namespaces
		- pod/"apps"
		- pod/dns-controller
		- pod/etcd-manager-events
		- pod/etcd-manager-main
		- pod/kops-controller
		- pod/kube-apiserver
		- pod/kube-controller-manager
		- pod/kube-dns
		- pod/kube-proxy
		- pod/kube-scheduler
		- services
		- deployment
		- replicaset


## Servicios
- Accediendo al pod a través de servicios:
```
$ kubectl create deployment httpenv --image jpetazzo/httpenv
$ kubectl expose deployment httpenv --port=8888
$ kubectl get service
```
- Tipo de servicios:
	- **ClusterIP**: Una IP virtual es asignada para el servicio
	- **NodePort**: Un puerto es asignado para el servicio en todos los nodos
	- **LoadBalancer**:
		- Un balanceador externo es provisionado para el servicio.
		- Sólo disponible cuando se usa un servicio con un balanceador
	- **ExternalName**: Una entrada de DNS manejado por CoreDNS.
	- Default is **ClusterIP**.
```
$ kubectl expose deploy/webui --type=NodePort --port 80
```

## Kubectl
- https://kubernetes.io/docs/reference/kubectl/overview/
- Ejecuta comandos en nuestro cluster.
- Syntax:
	- **kubectl [command] [TYPE] [NAME] [flags]**

## Healthchecks
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-readiness-probes
- https://kubernetesbyexample.com/healthz/
- **Tipos**:
	- liveness: error del cual el contenedor no se puede recuperar, k8s elimina el pod y crea uno nuevo.
	- readiness: error temporal, k8s reinicia el contenedor hasta que esté listo.
- **Mecanismos healthcheck**:
	- http
	- tcp
	- custome exec
- Ejm:
```
# Evaluar comando en contenedor
$ kubectl exec redis-65fd448c9b-8r8hz -ti bash
$ redis-cli asde
$ echo $?
>> 0
$ nofound
$ echo $?
>> 127

# Healthcheck liveness custome-exec
$ kubect edit deploy/redis
"""
spec:
	containers:
		-image: redis
		imagepull
		name:
+++		livenessProbe:
+++			exec:
+++				command: ["nofound"]
"""
$ kubectl get pod -w		>> kubernetes crea un nuevo pod
$ kubectl describe pod redis-59d6bfc7fc-9vqql >> ver estado del check
"""
    Restart Count:  1
    ...
    Warning  Unhealthy  5s (x4 over 35s)   kubelet, ip-172-20-57-230.ec2.internal  Liveness probe failed: OCI runtime exec failed: exec failed: container_linux.go:346: starting container proces caused "exec: \"nofound\": executable file not found in $PATH": unknown
"""
```

## Despliegues Controlados
- RollingUpdate es el método que utiliza k8s para actualizar la versión de la aplicación.
- Visualizar método RollingUpdate de los deploys
```
$ kubectl get deploy -o json | jq ".items[] | {name:.metadata.name} + .spec.strategy.rollingUpdate"
{
  "name": "hasher",
  "maxSurge": "25%",
  "maxUnavailable": "25%"
}
{
  "name": "redis",
  "maxSurge": "25%",
  "maxUnavailable": "25%"
}
{
  "name": "rng",
  "maxSurge": "25%",
  "maxUnavailable": "25%"
}
{
  "name": "webui",
  "maxSurge": "25%",
  "maxUnavailable": "25%"
}
{
  "name": "worker",
  "maxSurge": "25%",
  "maxUnavailable": "25%"
}
```
- Lectura maxSurge y maxUnavailable
	- maxUnavailable: deben haber un máximo de 25% de pods no disponibles
	- maxSurge: pueden haber 25% en rollingUpgrade (eliminandose creandose)

- Ejm:
```
$ kubectl get pods -w
NAME                      READY   STATUS    RESTARTS   AGE
hasher-99d4fdc78-gh2g4    1/1     Running   0          57m
redis-59d6bfc7fc-9vqql    1/1     Running   0          30m
rng-6979b4858b-8jvwx      1/1     Running   0          57m
webui-97d9f77cf-vmfxv     1/1     Running   0          57m
worker-598788db65-8fgh4   1/1     Running   0          56m

$ kubectl get replicasets -w
NAME                DESIRED   CURRENT   READY   AGE
hasher-99d4fdc78    1         1         1       58m
redis-59d6bfc7fc    1         1         1       32m
redis-65fd448c9b    0         0         0       58m
redis-fbdfcfd7f     0         0         0       34m
rng-6979b4858b      1         1         1       58m
webui-97d9f77cf     1         1         1       58m
worker-598788db65   1         1         1       58m

$ kubectl scale deploy/worker --replicas 5
$ kubectl get replicasets -w
admin@ip-172-20-59-31:~$ kubectl get replicasets -w
NAME                DESIRED   CURRENT   READY   AGE
hasher-99d4fdc78    1         1         1       58m
redis-59d6bfc7fc    1         1         1       32m
redis-65fd448c9b    0         0         0       58m
redis-fbdfcfd7f     0         0         0       34m
rng-6979b4858b      1         1         1       58m
webui-97d9f77cf     1         1         1       58m
worker-598788db65   1         1         1       58m
worker-598788db65   5         1         1       62m
worker-598788db65   5         1         1       62m
worker-598788db65   5         5         1       62m
worker-598788db65   5         5         2       62m
worker-598788db65   5         5         3       62m
worker-598788db65   5         5         4       62m
worker-598788db65   5         5         5       62m

$ kubectl set image deploy worker worker=dockercoins/worker:v0.2
$ kubectl get replicasets 
NAME                DESIRED   CURRENT   READY   AGE
hasher-99d4fdc78    1         1         1       71m
redis-59d6bfc7fc    1         1         1       44m
redis-65fd448c9b    0         0         0       71m
redis-fbdfcfd7f     0         0         0       47m
rng-6979b4858b      1         1         1       71m
webui-97d9f77cf     1         1         1       70m
worker-598788db65   0         0         0       70m
worker-bf575567b    5         5         5       3m9s

# Cometamos un error
$ kubectl set image deploy worker worker=dockercoins/worker:v0.3

$ kubectl get replicasets -w
NAME                DESIRED   CURRENT   READY   AGE
hasher-99d4fdc78    1         1         1       79m
redis-59d6bfc7fc    1         1         1       53m
redis-65fd448c9b    0         0         0       79m
redis-fbdfcfd7f     0         0         0       56m
rng-6979b4858b      1         1         1       79m
webui-97d9f77cf     1         1         1       79m
worker-598788db65   0         0         0       79m
worker-5bb865f85f   3         3         0       4m12s
worker-bf575567b    4         4         4       11m

$ kubectl get deploy
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
hasher   1/1     1            1           78m
redis    1/1     1            1           79m
rng      1/1     1            1           78m
webui    1/1     1            1           78m
worker   4/5     3            4           78m

# Revertir deploy
$ kubectl rollout undo deploy worker
admin@ip-172-20-59-31:~$ kubectl get replicasets
NAME                DESIRED   CURRENT   READY   AGE
hasher-99d4fdc78    1         1         1       84m
redis-59d6bfc7fc    1         1         1       57m
redis-65fd448c9b    0         0         0       84m
redis-fbdfcfd7f     0         0         0       60m
rng-6979b4858b      1         1         1       84m
webui-97d9f77cf     1         1         1       84m
worker-598788db65   0         0         0       83m
worker-5bb865f85f   0         0         0       8m38s
worker-bf575567b    5         5         5       16m
```

## Autoscaling y Daemon sets
- DaemonSet no se pueden crear por el kubectl, se crean a través del manifest file.
- DaemonSet permite crear un pod por nodo.
```
# Kubernetes hace el escalamiento identificando los pods por el label.
$ kubectl describe service rng
Name:              rng
Namespace:         default
Labels:            app=rng
Annotations:       <none>
Selector:          app=rng
Type:              ClusterIP
IP:                100.64.223.221
Port:              <unset>  80/TCP
TargetPort:        80/TCP
Endpoints:         100.96.1.5:80
Session Affinity:  None
Events:            <none>

# Seleccionamos el pod por el label
$ kubectl get pod --selector=app=rng -o wide
NAME                   READY   STATUS    RESTARTS   AGE     IP           NODE                            NOMINATED NODE   READINESS GATES
rng-6979b4858b-8jvwx   1/1     Running   0          4h33m   100.96.1.5   ip-172-20-48-177.ec2.internal   <none>           <none>

# Crear recurso daemon set
$ kubectl get deploy/rng -o yaml --export > rng.yml
$ vim rng.yml
"""
---kind: Deployment
+++kind: DaemonSet
"""
$ kubectl apply -f rng.yml --validate=false
$ kubectl get pod --selector=app=rng -o wide
NAME                   READY   STATUS    RESTARTS   AGE     IP            NODE                            NOMINATED NODE   READINESS GATES
rng-6979b4858b-8jvwx   1/1     Running   0          4h48m   100.96.1.5    ip-172-20-48-177.ec2.internal   <none>           <none>
rng-lkldv              1/1     Running   0          10m     100.96.1.18    ip-172-20-48-177.ec2.internal   <none>           <none>
rng-pnh44              1/1     Running   0          10m     100.96.2.18   ip-172-20-57-230.ec2.internal   <none>           <none>

# Eliminamos el label para que k8s realice el autoscaling.
$ kubectl label pod rng-6979b4858b-8jvwx app-
$ kubectl get pod --selector=app=rng -w
NAME                   READY   STATUS    RESTARTS   AGE    IP            NODE                            NOMINATED NODE   READINESS GATES
rng-6979b4858b-4clx2   1/1     Running   0          38s    100.96.2.19   ip-172-20-57-230.ec2.internal   <none>           <none>
rng-lkldv              1/1     Running   0          10m    100.96.1.18    ip-172-20-48-177.ec2.internal   <none>           <none>
rng-pnh44              1/1     Running   0          17m    100.96.2.18   ip-172-20-57-230.ec2.internal   <none>           <none>
```
- La comunicaición entre los pods lo realiza identificándolos por el label, al eliminar el label de un pod, k8s no puede identificarlo por lo que procede a eliminarlo y crear un nuevo pod.
- K8s al ser un sistema declarativo, escalará el servicio rng para que vuelva a su estado anterior.


## HELM
- Utilitario que nos ayuda hacer depliegues de forma sencilla.
```
// Instalar helm
$ curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

// Verificar si tenemos helm instalado
$ helm

// Configurar helm
$ helm init

// Verificar si Tiller está instalado
// Tiller se instala en el namespace administrativo: kube-system
$ kubectl get pods -n kube-system

// Dar permisos para ejecutar helm en nuestro cluster default
$ kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

// Buscar paquetes
$ helm search

// Ejemplo de cómo instalar un paquete
$ helm search prometheus
$ helm inspect stable/prometheus | less
$ helm install stable/prometheus --set server.service.type=NodePort --set server.persistentVolume.enabled=false

// Obtener servicios y verificar en què puerto está corriendo nuestra aplicación de prometheus
$ kubectl get svc

// Crear helm chart
$ helm create dockercoins
$ cd dockercoins
$ mv templates/ templates-old
$ mkdir templates
$ cd ..

// Exportar los recursos de nuestra aplicación
$ kubectl get -o yaml --export deployment worker
"""
while read kind name; do
kubectl get -o yaml --export $kind $name > dockercoins/templates/$name-$kind.yaml
done <<EOF
deployment worker
deployment hasher
daemonset rng
deployment webui
deployment redis
service hasher
service rng
service webui
service redis
EOF
"""
$ helm install dockercoins >> Este comando nos dará error porque nos indicará que el recurso ya existe, para ello necesitaremos manejar los namespaces.
```

## Namespaces
- https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
- Kubernetes admite múltiples clústeres virtuales montados por el mismo clúster físico.
- Estos clústeres virtuales se denominan namespaces.
- Permite aislar los recursos y tener una visibilidad segregada.
```
$ kubectl get namespace
NAME              STATUS   AGE
default           Active   54m
kube-node-lease   Active   54m
kube-public       Active   54m
kube-system       Active   54m
```
- Prompt info for bash and zsh: https://github.com/jonmosco/kube-ps1
```
$ kubectl create namespace blue
$ kubectl -n blue get svc
$ kubectl config get-contexts
```
- Comunición a la api de kubernetes desde un pod
```
$ kubectl run --image alpine -ti bash
~ apk add --no-cache curl
~ curl -k https://kubernetes.default.svc.cluster.local:443/
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {

  },
  "status": "Failure",
  "message": "Unauthorized",
  "reason": "Unauthorized",
  "code": 401
```

- Un recurso es único con estos 3 parámetros:
	- Tipo de recurso - Nombre del recurso - Namespace

- Un pod en el namespace **default** puede comunicarse con otro en el **kube-system**.
- No provee aislación de recursos.
- Crear un recurso evitando colisión:
```
$ kubectl config set-context --current --namespace=blue
$ kubectl config get-contexts
CURRENT   NAME                      CLUSTER   AUTHINFO   NAMESPACE
*         service-account-context   local     kubecfg    blue

$ kubectl get pods
No resources found in blue namespace.

$ helm install dockercoins
$ kubectl get svc
```

## ConfigMaps
- Configurar aplicaciones con un archivo.
```
$ cat > haproxy.cfg
"""
global
  daemon
  maxconn 256

defaults
  mode tcp
  timeout connect 5000ms
  timeout client 50000ms
  timeout server 50000ms

frontend the-frontend
  bind *:80
  default_backend the-backend

backend the-backend
  server google.com-80 google.com:80 maxconn 32 check
  server ibm.fr-80 ibm.fr:80 maxconn 32 check
"""

$ kubectl create configmap haproxy --from-file=haproxy.cfg
$ cat > haproxy.yaml
"""
apiVersion: v1
kind: Pod
metadata:
  name: haproxy
spec:
  volumes:
  - name: config
    configMap:
      name: haproxy
  containers:
  - name: haproxy
    image: haproxy
    volumeMounts:
    - name: config
      mountPath: /usr/local/etc/haproxy
"""

$ kubectl apply -f haproxy.yaml
$ kubectl get pod haproxy -o wide
NAME      READY   STATUS    RESTARTS   AGE   IP            NODE                            NOMINATED NODE   READINESS GATES
haproxy   1/1     Running   0          36s   100.96.2.20   ip-172-20-57-230.ec2.internal   <none>           <none>

$ curl 100.96.2.20
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

$ curl 100.96.2.20
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>301 Moved Permanently</title>
</head><body>
<h1>Moved Permanently</h1>
<p>The document has moved <a href="http://www.ibm.com/">here</a>.</p>
</body></html>
```

- Configurar aplicaciones con una variable
```
$ kubectl create configmap registry --from-literal=http.addr=0.0.0.0:80
"""
apiVersion: v1
kind: Pod
metadata:
  name: registry
spec:
  containers:
  - name: registry
    image: registry
    env:
    - name: REGISTRY_HTTP_ADDR
      valueFrom:
        configMapKeyRef:
          name: registry
          key: http.addr
"""
$ kubectl apply -f registry.yaml
$ kubectl get pods -o wide | grep registry
registry                 1/1     Running   0          4m59s   10.44.0.2        <none>                          <none>           <none>

$ curl http://10.44.0.2:80/v2/_catalog
```

## Volúmenes
- Compartir archivos entre diferentes pods.
- Guardan logs, secretos (registros sensibles)

```
# Creación de un volúmen emptyDir.
$ cat > nginx-with-volume.yaml
"""
apiVersion: v1
kind: Pod
metadata:
  name: nginx-with-volume
spec:
  volumes:
  - name: www
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - name: www
      mountPath: /usr/share/nginx/html/
  - name: git
    image: alpine
    command: [ "sh", "-c", "apk add --no-cache git && git clone https://github.com/octocat/Spoon-Knife /www" ]
    volumeMounts:
    - name: www
      mountPath: /www/
  restartPolicy: OnFailure
"""
$ kubectl apply -f nginx-with-volume.yaml
$ kubectl describe pods nginx-with-volume
"""
Containers:                                                                                                                                                                            [32/1757]
  nginx:
    Container ID:   docker://eba3bd9cb72aaf2b42a51addc34111aba7504c91f077ba676b6a2d3e30a444d3
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:d81f010955749350ef31a119fb94b180fde8b2f157da351ff5667ae037968b28
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 22 Apr 2020 23:52:50 +0000
    Ready:          True
    Restart Count:  0
    Requests:
      cpu:        100m
    Environment:  <none>
    Mounts:
      /usr/share/nginx/html/ from www (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-ddnt7 (ro)
  git:
    Container ID:  docker://37f64a5126ca77f18a783b563e334b714aba08019c682b18b121f05af552b2f6
    Image:         alpine
    Image ID:      docker-pullable://alpine@sha256:b276d875eeed9c7d3f1cfa7edb06b22ed22b14219a7d67c52c56612330348239
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      apk add --no-cache git && git clone https://github.com/octocat/Spoon-Knife /www
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Wed, 22 Apr 2020 23:52:51 +0000
      Finished:     Wed, 22 Apr 2020 23:52:52 +0000
    Ready:          False
    Restart Count:  0
    Requests:
      cpu:        100m
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-ddnt7 (ro)
      /www/ from www (rw)
"""

$ kubectl get pods nginx-with-volume -o wide
NAME                READY   STATUS    RESTARTS   AGE   IP            NODE                            NOMINATED NODE   READINESS GATES
nginx-with-volume   1/2     Running   0          54s   100.96.2.22   ip-172-20-57-230.ec2.internal   <none>           <none>

$ curl 100.96.2.22
```
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/kubernetes-docker.png)

### Ciclo de vida: Volúmenes
- Está relacionado al ciclo de vida de los PODS
- El volúmen se crea cuando el POD se crea:
	- Esto aplica principalmente para los volúmenes emptyDir.
	- Para otro tipo se conectan en vez de crearse.
- Un volúmen se mantiene aún cuando se reinicie el contenedor.
- Un volúmen se destruye cuando el POD se elimina. (Ojo con los rollout.)


## Autenticación y autorización
- Autenticación es el método por el cual Kubernetes deja ingresar a un usuario.
- Autorización es el mecanismo para que un usuario tenga una serie determinada de permisos para realizar ciertas acciones sobre el cluster.
- Cuando el API server recibe un request intenta autorizarlo con uno o más de uno de los siguientes métodos:
	- Certificados TLS
	- Bearer Tokens
	- Basic Auth
	- Proxy de autenticación.
- Si cualquier método rechaza la solicitud, se devuelve un 401.
- Si el request no es aceptado o rechazado, el usuario es anónimo.
- Por defecto el usuario anónimo no puede hacer ninguna operación en el cluster.

```
# Visualizar los permisos de nuesto usuario kubernetes
$ kubectl get svc kubernetes
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   100.64.0.1   <none>        443/TCP   9h

$ curl -k https://100.64.0.1
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {

  },
  "status": "Failure",
  "message": "Unauthorized",
  "reason": "Unauthorized",
  "code": 401

$ kubectl config view --raw -o json | jq -r .users[0].user[\"client-certificate-data\"] | base64 -d | openssl x509 -text | grep Subject
        Subject: O = system:masters, CN = kubecfg
        Subject Public Key Info:
```

### Service account tokens
- Existen en la API de kubernetes. (kubectl get serviceaccounts)
- Pueden crearse / eliminarse y actualizarse.
- Un service account está asociado a secretos (kubectl get secrets)
- Son utilizados para otorgar permisos a aplicaciones y servicios.
```
# Obtener token
$ kubectl get sa
NAME      SECRETS   AGE
default   1         9h

$ kubectl get sa default -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2020-04-22T15:59:07Z"
  name: default
  namespace: default
  resourceVersion: "287"
  selfLink: /api/v1/namespaces/default/serviceaccounts/default
  uid: d7e13607-9656-4b1e-a439-06bc491bc2ad
secrets:
- name: default-token-ddnt7

$ kubectl get sa default -o json | jq -r .secrets[0].name
default-token-ddnt7

$ kubectl get secret default-token-ddnt7 -o yaml
$ kubectl get secret default-token-ddnt7 -o json | jq -r .data.token | base64 -d

# Autenticarnos
$ kubectl get svc kubernetes -n default
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   100.64.0.1   <none>        443/TCP   9h

$ kubectl config set-context --current --namespace=blue
$ curl -k https://100.64.0.1
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {
    
  },
  "status": "Failure",
  "message": "Unauthorized",
  "reason": "Unauthorized",
  "code": 401
}
$ curl -k https://100.64.0.1 -H "Authorization: Bearer eyJhbGciOiJSUzI1NiImtpxxxx"
```

### RBAC
Role based access control(RBAC) es un mecanismo de kubernetes para gestionar roles y la asociación de estos a los usuarios para delimitar las acciones que pueden realizar dentro de la plataforma.
- Un rol es un objeto que contiene una lista de rules.
- Un rolebiding asocia un rol a un usuario.
- Pueden existir usuarios, roles y rolebidings con el mismo nombre.
- Una buena práctica es tener un 1-1-1 bidings.
- Los Cluster-scope permissions permiten definir permisos a nivel de cluster y no solo namespace.
- Un pod puede estar asociado a un service-accoun.
	- El token se encuentra en (/var/run/secrets)
```
# Visualizr permisos
$ kubectl get clusterrolebindings
$ kubectl describe clusterrolebindings cluster-admin
Name:         cluster-admin
Labels:       kubernetes.io/bootstrapping=rbac-defaults
Annotations:  rbac.authorization.kubernetes.io/autoupdate: true
Role:
  Kind:  ClusterRole
  Name:  cluster-admin
Subjects:
  Kind   Name            Namespace
  ----   ----            ---------
  Group  system:masters  

$ kubectl create deployment testrbac --image nginx
$ kubectl auth can-i list nodes
$ kubectl auth can-i create pods
$ kubectl auth can-i get pods --as kube-admin

# Crear recursos con una cuenta
$ kubectl create sa viewer
$ kubectl get sa
$ kubectl create rolebinding viewercanview --clusterrole=view --serviceaccount=default:viewer
$ kubectl run eyepod --rm -ti --restart=Never --serviceaccount=viewer --image alpine
```