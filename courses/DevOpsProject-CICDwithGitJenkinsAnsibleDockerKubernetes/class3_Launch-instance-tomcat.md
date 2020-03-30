## Launch Instance
- AMI: Ubuntu Server 18.04 LTS
- Instance Type: t2.micro
- SG ports: 22;8080

## [Install Java](../class1_Launch-instance-jenkins.md)

## Install Tomcat
```
cd /opt/
sudo wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz
sudo tar -xvzf apache-tomcat-8.5.51.tar.gz 
sudo mv apache-tomcat-8.5.51 tomcat
sudo rm apache-tomcat-8.5.51.tar.gz
```

## Running
```
sudo hostname tomcat-server
cd /opt/tomcat/bin
./startup.sh
```
* IPtomcat-server:8080

## Fix login
* IPtomcat-server:8080/manager/html
Now application is accessible on port 8080. but tomcat application doesn't allow to login from browser. Changing a default parameter in context.xml does address this issue .
- Search for context.xml
```
find / -name context.xml
>>>/opt/tomcat/webapps/manager/META-INF/context.xml
>>>/opt/tomcat/webapps/host-manager/META-INF/context.xml
>>>/opt/tomcat/conf/context.xml
sudo vim /opt/tomcat/webapps/manager/META-INF/context.xml
"""
~~~
<!--<Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
"""
sudo vim /opt/tomcat/webapps/host-manager/META-INF/context.xml
"""
~~~
<!--<Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
"""
```

## Update users information
Update users information in the tomcat-users.xml file goto tomcat home directory and Add below users to conf/tomcat-user.xml file
```
vim /opt/tomcat/conf/tomcat-users.xml
"""
+++
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
<user username="deployer" password="deployer" roles="manager-script"/>
<user username="tomcat" password="s3cret" roles="manager-gui"/>
"""
cd /opt/tomcat/bin
./shutdown.sh
./startup.sh
```