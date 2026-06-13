#!/bin/bash
echo "=== Iniciando Deploy Continuo (CD) no Servidor EC2 ==="

# 1. Baixar a ultima versão do container do registro (Simulado)
echo "=> Executando Pull da imagem Docker mais recente..."
docker pull pedrokbock/api-devops-pucrs:latest

# 2. Parar o container antigo para liberar a porta 80
echo "=> Parando e removendo containers antigos ativos..."
docker stop api-web-prod || true
docker rm api-web-prod || true

# 3. Iniciar o novo container mapeando a porta de rede do host
echo "=> Inicializando o novo container na porta 80..."
docker run -d --name api-web-prod -p 80:80 pedrokbock/api-devops-pucrs:latest

echo "=== Deploy finalizado com sucesso e monitoramento ativo! ==="
