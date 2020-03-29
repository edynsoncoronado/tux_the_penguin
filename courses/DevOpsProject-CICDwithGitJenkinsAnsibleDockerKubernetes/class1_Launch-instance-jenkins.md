## Launch Instance
- AMI: Ubuntu Server 18.04 LTS
- Instance Type: t2.micro
- SG ports: 22;8080

## Install Java
```
sudo su
add-apt-repository ppa:webupd8team/java
apt update
apt install openjdk-8-jdk -y
# $ java -version
# >>> openjdk version "1.8.0_242"
vim ~/.bashrc
"""
+++
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_HOME
PATH=$PATH:$JAVA_HOME
"""
source ~/.bashrc
echo $JAVA_HOME
>>> /usr/lib/jvm/java-8-openjdk-amd64
```
* (What is the difference between JDK and JRE?)[https://stackoverflow.com/a/1906455]

## Install Jenkins
```
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
apt update
apt install -y jenkins
systemctl start jenkins
# service jenkins start
# IP:8080
```
* (How can I append text to /etc/apt/sources.list from the command line?)[https://stackoverflow.com/a/850731]

## Configure Jenkins
1) Password Location:/var/lib/jenkins/secrets/initialAdminPassword
2) No install pluging
3) The Username default is admin
4) Change admin password
	admin > Configure > Password
5) Configure java path
	Manage Jenkins > Global Tool Configuration > JDK  
	- NAME: JAVA_HOME
	- JAVA_HOME: /usr/lib/jvm/java-8-openjdk-amd64



