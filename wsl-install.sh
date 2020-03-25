#!/bin/bash
# Check if running as root
if [[ "$EUID" -ne 0 ]]
  then echo "Please run as root"
  exit
fi
# Update the apt package list.
echo "Updating package list"
sudo apt-get update -y > /dev/null 2>&1

# Install Docker's package dependencies.
echo "Installing dependencies"
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common > /dev/null 2>&1
# Download and add Docker's official public PGP key.
echo "Getting Docker public PGP key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null 2>&1
# Verify the fingerprint.
echo "
#######################################
       Please verify this output       
#######################################

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Should match Output:

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
sudo apt-key fingerprint 0EBFCD88
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
# Add the `stable` channel's Docker upstream repository.
echo "Adding stable Docker repository"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" > /dev/null 2>&1
# Update the apt package list (for the new apt repo).
echo "Updating package list (added Docker repo)"
sudo apt-get update -y > /dev/null 2>&1
# Install the latest version of Docker CE.
echo "Installing Docker"
sudo apt-get install -y docker-ce > /dev/null 2>&1
# Allow your user to access the Docker CLI without needing root access.
echo "Allowing user to run Docker without root access"
sudo usermod -aG docker $USER > /dev/null 2>&1
sudo chmod 666 /var/run/docker.sock > /dev/null 2>&1
# Install Python and PIP.
echo "Installing Python and PIP (needed for Docker-Compose)"
sudo apt-get install -y python python-pip > /dev/null 2>&1
# Install Docker Compose into your user's home directory.
echo "Installing Docker-Compose"
pip install --user docker-compose > /dev/null 2>&1
if grep -Fxq 'export PATH="$PATH:$HOME/.local/bin"' ~/.profile
then
    echo "do nothing" > /dev/null 2>&1
else
    echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.profile && source ~/.profile > /dev/null 2>&1
fi
if grep -Fxq "export DOCKER_HOST=tcp://localhost:2375" ~/.bashrc
then
    echo "do nothing" > /dev/null 2>&1
else
    echo "export DOCKER_HOST=tcp://localhost:2375" >> ~/.bashrc && source ~/.bashrc > /dev/null 2>&1
fi
echo "
Make sure to check the box to Expose daemon on tcp://localhost:2375 without TLS in docker settings.
This step is not needed if using WSL version 2.  

For more information on WSL version 2, please view the readme:
https://github.com/PR-lacity/wsl-docker/blob/master/README.md

Finished."
