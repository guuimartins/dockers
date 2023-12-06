#!/bin/bash

#VERIFICA SE O SCRIPT ESTÁ SENDO EXECUTADO EM MODO ROOT
if [ "$EUID" -ne 0 ]
  then echo "Por favor, execute o script em modo root (sudo su)"
  exit;
fi

clear
echo "Atualizando o docker:"

sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

echo "Atualizando o docker compose"

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose -y
sudo chmod +x /usr/local/bin/docker-compose -y

echo
echo "Docker atualizado."
echo "Versão abaixo:"
echo

sudo docker --version
docker-compose --version