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
**a) kube-apiserver**
	- Expone la api de kubernetes.
	- Es la interfaz que sirve como medio de comunicación entre los agentes, CLI o el dashboardy el nodo master.
	- Se usa el algoritmo de raft para algoritmo deelección. https://raft.github.io/ 
**b) kube-scheduler**
	- Se encarga de revisar las restricciones y recursos disponibles al crear un job, un pod en máquinas específicas.
**c) kube-controller-manager**
	- Es un proceso que estàn en un ciclo de reconciliación constante buscando llegar al estado deseado con base al modelo declarativo con el que se le dan instrucciones a K8s.
	- Tipos:
		- Replica manager
		- Deployment manager
		- Service manager
**d) cloud-controller-manager**
	- Permite que el código de proveedores en la nube y el código de kubernetes evolucionen de forma independiente entre sí.
**e) etcd**
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





###############################

què es kubernetes

	infraestructura de kubernetes
	caracteristicas
	- kubelet
	- etcd
	- kube-apiserver
	- docker
mecanismos de healthcheck
	- liveness
	- readiness
recursos de kubernetes
identificación de recursos
helm
	- chart
que es un pod
minion
componentes de kubernetes
kubectl
rollback a un deployment
maxSurge y maxUnavailable
daemonSet
readiness
rbac
canary-deployment
servicios
	accediendo a servicios

rolebiding
mecanismos de autenticación
replication controller
namespaces
	- default
	- kube-system
	- kube-adin
	- kube-public
daemon-set