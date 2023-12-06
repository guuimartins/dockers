#!/bin/bash

clear
# Instalando o Docker
echo "Instalando o Docker"

# Atualizar a lista de pacotes
sudo apt update -y

# Instalar dependências
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Adicionar a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adicionar o repositório estável do Docker
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizar a lista de pacotes após adicionar o repositório
sudo apt update -y

# Instalar a versão mais recente do Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Adicionar o usuário ao grupo "docker" para executar comandos Docker sem sudo
sudo usermod -aG docker $USER

# Reiniciar o serviço Docker
sudo systemctl restart docker

# ----- Instalar o Docker Compose -----
clear
echo "Instalando o Docker Compose"

# Baixar a versão mais recente do Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Dar permissão de execução ao binário do Docker Compose
sudo chmod +x /usr/local/bin/docker-compose

# Criar um link simbólico para o comando "docker-compose"
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Verificar a instalação
docker --version
docker-compose --version
