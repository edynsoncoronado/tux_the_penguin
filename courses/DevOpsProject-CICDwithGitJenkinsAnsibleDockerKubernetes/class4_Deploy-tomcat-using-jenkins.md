## Install Plugin
- Manage Jenkins > Manage Plugins > Available > Deploy to container (https://plugins.jenkins.io/deploy/)

## New Job
1) New Item > Maven project
	- Name: Deploy_tomcat_on_container
2) Source Code Management > Git
	- Repository URL: https://github.com/edynsoncoronado/hello-world.git
	- Branches to build: \*/master
3) Build
	- Root POM: pom.xml
4) Post-build Actions > Deploy war/ear to a container
	- WAR/EAR files: **/*.war
	- Containers: Tomcat 8.x Remote
	- add Credentials:
		- Username: deployer
		- Password: deployer
		- ID: deployer_user
		- Description: deploy on tomcat
	- selecting Credentials
	- Tomcat URL: http://IPtomcat-server:8080
5) Build job
```
# Server tomcat
cd /opt/tomcat/webapps
ls
# before build
ROOT  docs  examples  host-manager  manager
# after build
ROOT  docs  examples  host-manager  manager  webapp  webapp.war
```
