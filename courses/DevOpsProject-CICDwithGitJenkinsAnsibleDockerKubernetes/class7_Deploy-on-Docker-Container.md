## DockerServer: Create dockerfile
```
su - dockeradmin
pwd
>>> /home/dockeradmin
vim Dockerfile
"""
FROM tomcat:8.0

COPY ./webapp.war /usr/local/tomcat/webapps
"""
```

## DockerServer: Build
```
docker build -t devops-project .
```

## DockerServer: RUN
```
docker run -d --name devops-container -p 8080:8080 devops-project
```
* IPdockerserver:8080
```
docker rm -f devops-container
docker rmi devops-project:latest
```

## DockerServer: New Job
1) New Item
	- Name: Deploy_on_Container
	- Copy from: Deploy_on_Docker
2) Change Post-build Actions
	Exec command: cd /home/dockeradmin; docker build -t devops-image .; docker run -d --name devops-container -p 8080:8080 devops-image;

## Error!
	- First Build -> SUCCESS
	- Second Build -> UNSTABLE
	To solve this error we have to use Ansible, installation and configuration in the next class.