#!/bin/bash

clear

# VERIFICA SE O SCRIPT ESTÁ SENDO EXECUTADO EM MODO ROOT
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute o script em modo root (sudo su)"
  exit
fi

echo "Iniciando a instalação"

# Instalando o o repositório
wget https://github.com/MatchbookLab/local-persist/releases/download/v1.3.0/local-persist-linux-amd64

mv local-persist-linux-amd64 docker-volume-local-persist

mv docker-volume-local-persist /usr/bin

chmod +x /usr/bin/docker-volume-local-persist

# Criando o arquivo docker-volume-local-persist.service
ARQUIVO_PERSIST="docker-volume-local-persist.service"

# Criar o conteúdo do arquivo
CONTEUDO_ARQUIVO="[Unit]
Description=docker-volume-local-persist
Before=docker.service
Wants=docker.service

[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/docker-volume-local-persist

[Install]
WantedBy=multi-user.target"

# Escrever o conteúdo no arquivo
echo "$CONTEUDO_ARQUIVO" > "$ARQUIVO_PERSIST"

# Movendo para o diretório correto
mv docker-volume-local-persist.service /etc/systemd/system/

# Iniciando todos os serviços do plugin
sudo systemctl daemon-reload
sudo systemctl enable docker-volume-local-persist
sudo systemctl start docker-volume-local-persist

echo
echo "Finalizado a instalação e configuração do plugin!"