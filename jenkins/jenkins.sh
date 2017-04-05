#!/bin/bash

UBUNTU_VERSION=xenial
JENKINS_VERSION=2.7.4

COMMON_PKG=(
git
tree
)


# install comman's packages
for i in ${COMMON_PKG[@]}; do
  sudo apt-get -y install $i
done

# install jenkins
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update

sudo apt-get install jenkins
