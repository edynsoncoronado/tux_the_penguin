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
a) kube-apiserver
	- Expone la api de kubernetes.
	- Es la interfaz que sirve como medio de comunicación entre los agentes, CLI o el dashboardy el nodo master.
	- Se usa el algoritmo de raft para algoritmo deelección. https://raft.github.io/
b) kube-scheduler
	- Se encarga de revisar las restricciones y recursos disponibles al crear un job, un pod en máquinas específicas.
c) kube-controller-manager
	- Es un proceso que estàn en un ciclo de reconciliación constante buscando llegar al estado deseado con base al modelo declarativo con el que se le dan instrucciones a K8s.
	- Tipos:
		- Replica manager
		- Deployment manager
		- Service manager
d) cloud-controller-manager
	- Permite que el código de proveedores en la nube y el código de kubernetes evolucionen de forma independiente entre sí.
e) etcd
	- Key value store que permite que el cluster estealtamente disponible.
	- Utilizado como almacén de respaldo de kubernetes para todos los datos del clúster.
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/arquitecturak81.png)

### Nodo
**a) Kubelet**  
	- Agente de kubernetes  
	- Se comunica con el control play y pregunta qué recursos (pods, contenedores) debe correr.  
	- Monitorea los pods constantemente para saber si están vivos, los recursos disponibles.  
**b) Kube-proxy**  
	- Se encarga de balancear el tráfico de red que corre en nuestros contenedores/servicios  
	- Una vez llega un request se encarga de decidir a qué pod y contenedor debe ir.  
**c) Container Runtime**  
	- Kubernetes admite varios tipos de ejecución:  
		- Docker  
		- Containerd  
		- Cri-o  
		- Rktlet  
		- Cualquier implementación del CRI de Kubernetes  
**d) Nodo == Minions**  
	- Todos los nodos y master están conectados a una red física para poder hablarse entre sí.  
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/arquitecturak82.png)

##¿Qué es un pod?
- Es la unidad básica de ejecución de una aplicación en K8s.
- Representa al proceso en ejecución en el cluster.
- Encapsula un contenedor de aplicaciones o en algunos casos, múltiples contenedores.
Pueden ser usados de dos maneras:
- **Pods que ejecutan un contenedor:**
	- En este caso un pod es representado como una envoltura de un contenedor (Pod as a wrapper around a single container).
- **Pods que ejecutan múltiples contenedores que necesitan trabajar juntos:**
	- El Pod encampsula una aplicación compuesta de múltiples contenedores acoplados que necesitan compartir recursos.

```
admin@ip-172-20-46-79:~$ kubectl get pods -o wide
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
kubectl create deployment httpenv --image jpetazzo/httpenv
kubectl expose deployment httpenv --port=8888
kubectl get service
```
- Tipo de servicios:
	- ClusterIP: Una IP virtual es asignada para el servicio
	- NodePort: Un puerto es asignado para el servicio en todos los nodos
	- LoadBalancer: Un balanceador externo es provisionado para el servicio.
Sólo disponible cuando se usa un servicio con un balanceador
	- ExternalName: Una entrada de DNS manejado por CoreDNS.
	- Default is 'ClusterIP'.

```
kubectl expose deploy/webui --type=NodePort --port 80
```

## Kubectl
- https://kubernetes.io/docs/reference/kubectl/overview/
- Ejecuta comandos en nuestro cluster.
- Syntax:
	- kubectl [command] [TYPE] [NAME] [flags]

## Namespaces
- https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
- Kubernetes admite múltiples clústeres virtuales montados por el mismo clúster físico.
- Estos clústeres virtuales se denominan namespaces.
```
admin@ip-172-20-46-79:~$ kubectl get namespace
NAME              STATUS   AGE
default           Active   54m
kube-node-lease   Active   54m
kube-public       Active   54m
kube-system       Active   54m
```

## Healthchecks
- 

###############################


mecanismos de healthcheck
	- liveness
	- readiness
rollback a un deployment
maxSurge y maxUnavailable
daemon-set
replication controller
helm
	- chart
canary-deployment
mecanismos de autenticación
rbac
rolebiding





