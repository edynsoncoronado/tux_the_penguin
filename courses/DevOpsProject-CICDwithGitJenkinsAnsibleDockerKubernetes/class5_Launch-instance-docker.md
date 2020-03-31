## Launch Instance
- AMI: Ubuntu Server 18.04 LTS
- Instance Type: t2.micro
- SG ports: 22;8080

## Install Docker
```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker ubuntu
```

## Run Docker Tomcat
```
docker pull tomcat
docker run -d --name tomcat-container -p 8080:8080 tomcat:latest
# docker rm tomcat:latest
```

## Tomcat Docker Issue
```
docker exec -it tomcat-container /bin/bash
pwd
>> /usr/local/tomcat
cp -R webapps.dist/* webapps
```
*IPserverdocker:8080


## Tomcat:8.0 Docker Image
```
docker pull tomcat:8.0
docker run -d --name tomcat-8 -p 8081:8080 tomcat:8.0
```
*IPserverdocker:8081