#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get install -y openjdk-8-jre
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update
sudo apt-get install -y jenkins
sudo systemctl start jenkins
