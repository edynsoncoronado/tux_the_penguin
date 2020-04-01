## DockerServer: Create user en DockerServer
```
sudo useradd -m -U -s /bin/bash dockeradmin
sudo passwd dockeradmin
sudo usermod -aG docker dockeradmin
```
* Verificar grupo docker en usuario creado
```
cat /etc/group
id dockeradmin
```

## DockerServer: ssh config
```
vim /etc/ssh/sshd_config
"""
~~~
PasswordAuthentication yes
"""
service ssh reload
```

## JenkinsServer: Install Plugin
- Manage Jenkins > Manage Plugins > Available > Publish Over SSH (https://plugins.jenkins.io/publish-over-ssh/)

## JenkinsServer: Setup SSH Servers
1) Manage Jenkins > Configure System > Publish over SSH > SSH Servers (add)
	- Name: docker-host
	- Hostname: IPprivateserverdocker
	- Username: dockeradmin
2) Click Advanced and Check "Use password authentication, or use a different key"
	- Passphrase / Password: ******
3) Click "Test Configuration"

* IPprivateserverdocker
```
$ ip addr 
```

## JenkinsServer: New Job
Copy artifacts on to docker host:
1) New Item
	- Name: Deploy_on_Docker
	- Copy from: Deploy_tomcat_on_container
2) Uncheck Poll SCM
3) Remove Post-build Actions
4) add Post-buid Actions > Send build artifacts over SSH
	- Name: (Setup SSH Servers - step1)
	- Source files: webapp/target/*.war
	- Remove prefix: webapp/target
	- Remote directory: .
5) Saved job and build
6) connect DockerServer
```
$ ls
>>webapp.war
```