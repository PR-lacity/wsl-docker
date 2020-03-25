#!/bin/bash
# Check if running as root
if [[ "$EUID" -ne 0 ]]
  then echo "Please run as root"
  exit
fi
# Update the apt package list.
apt-get update -y
# Install Docker's package dependencies.
apt-get install apt-transport-https ca-certificates curl software-properties-common
# Download and add Docker's official public PGP key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add the `stable` channel's Docker upstream repository.
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
# Update the apt package list (for the new apt repo).
apt-get update -y
# Install the latest version of Docker CE.
apt-get install -y docker-ce
# Allow access to the Docker CLI without needing root access.
usermod -aG docker $USER
#Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
#Add docker to bashrc so it can be run anytime a terminal is opened.
echo "export DOCKER_HOST=tcp://localhost:2375" >> ~/.bashrc && source ~/.bashrc
echo "Make sure to check the box to Expose daemon on tcp://localhost:2375 without TLS in docker settings.
This step is not needed if using WSL version 2.  For more information on WSL version 2, please view the readme https://github.com/PR-lacity/wsl-docker/blob/master/README.md

Finished."
exit
