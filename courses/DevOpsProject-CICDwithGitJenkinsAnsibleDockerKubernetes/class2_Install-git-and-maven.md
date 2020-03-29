## Install GIT
```
sudo hostname jenkins-server
sudo su -
sudo apt install git -y
```

## Install Plugin git in jenkins
- Manage Jenkins > Manage Plugins > Avaible > github (https://plugins.jenkins.io/github/)

## Configure git path
- Manage Jenkins > Global Tool Configuration > Git
	- Name: github
	- Path to Git executable: git

## Intall Maven
```
cd /opt/
sudo wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
sudo tar -xvzf apache-maven-3.6.3-bin.tar.gz 
sudo mv apache-maven-3.6.3 maven
sudo rm apache-maven-3.6.3-bin.tar.gz
sudo vim ~/.bashrc
"""
+++
M2_HOME=/opt/maven
M2=$M2_HOME/bin
export M2_HOME
export M2
PATH=$PATH:$M2_HOME:$M2
"""
sudo source ~/.bashrc
mvn --version
```

## Install Plugin maven in jenkins
- Manage Jenkins > Manage Plugins > Available > Maven Integration
- Manage Jenkins > Manage Plugins > Available > Maven Invoker

## Configure maven path
- Manage Jenkins > Global Tool COnfiguration > Maven > Uncheck Install automatically
	- Name: M2_HOME
	- MAVEN_HOME: /opt/maven

## Maven Job
1) New Item > Maven project
	- Name: Firs_maven_project
2) Source Code Management > Git
	- Repository URL: https://github.com/edynsoncoronado/hello-world.git
	- Branches to build: \*/master
3) Build
	- Root POM: pom.xml

* **Project workspace:** /var/lib/jenkins/workspace/Firs_maven_project