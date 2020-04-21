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