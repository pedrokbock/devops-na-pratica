const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('API do Projeto DevOps PUCRS - Fase 2: Online e Roteando!');
});

// O Dockerfile expõe a porta 80, então o servidor precisa ouvir nela
app.listen(80, () => {
  console.log('Servidor rodando com sucesso na porta 80!');
});
