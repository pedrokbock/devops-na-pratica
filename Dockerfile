# Utiliza a imagem oficial leve do Node.js baseada em Alpine Linux
FROM node:20-alpine

# Define o diretorio de trabalho dentro do container
WORKDIR /usr/src/app

# Copia os arquivos de mapeamento de dependencias
COPY package*.json ./

# Instala apenas as dependencias de producao para otimizar o tamanho da imagem
RUN npm ci --only=production

# Copia o restante do codigo-fonte da aplicacao
COPY . .

# Expõe a porta interna da aplicacao (Porta 80 conforme planejado na infraestrutura)
EXPOSE 80

# Comando de inicializacao do container
CMD [ "npm", "start" ]
