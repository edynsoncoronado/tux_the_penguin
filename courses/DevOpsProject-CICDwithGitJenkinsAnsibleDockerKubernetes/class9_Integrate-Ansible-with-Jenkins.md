## JenskinsServer: Configure SSH
1) Manage Jenkins > Configure System > Publish over SSH > SSH Servers > add
	- Name: ansible-server
	- Hostname: IPprivateansible
	- Username: ansadmin
2) Advanced:
	- check Use password authentication, or use a different key
	- Passphrase / Password: *****

## AnsibleServer: Directory Docker
```
sudo mkdir /opt/docker
sudo chown -R ansadmin:ansadmin /opt/docker
```

## JenkinsServer: New Job
1) New Item
	- Name: Deploy_on_Container_using_ansible
	- Copy from: Deploy_on_Container
2) Modificar: Send build artifacts over ssh
	- ssh server > name: (Configure SSH - ansible-server)
	- Transfers:
		- Source files: webapp/target/*.war
		- Remove prefix: webapp/target
		- Remote directory: //opt//docker
		- Exec command:
3) Save and Build Now:
```
# AnsibleServer
cd /opt/docker
ls
>>> webapp.war
```
