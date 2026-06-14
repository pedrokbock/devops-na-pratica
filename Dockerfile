# Utiliza a imagem oficial leve do Node.js baseada em Alpine Linux
FROM node:20-alpine

# Define o diretorio de trabalho dentro do container
WORKDIR /usr/src/app

# Copia os arquivos de mapeamento de dependencias
COPY package*.json ./

# Instala as dependencias de producao (MUDANÇA AQUI)
RUN npm install --production

# Copia o restante do codigo-fonte da aplicacao
COPY . .

# Expõe a porta interna da aplicacao (Porta 80)
EXPOSE 80

# Comando de inicializacao do container
CMD [ "npm", "start" ]
