FROM node:18-alpine

WORKDIR /app

# Copie arquivos de configuração
COPY package.json package-lock.json .npmrc ./

# Instale dependências explicitamente na ordem correta
RUN npm config set legacy-peer-deps true
RUN npm config set strict-peer-dependencies false

# Instale React primeiro
RUN npm install react@18.2.0 react-dom@18.2.0 scheduler@0.23.2 --legacy-peer-deps --save

# Instale todas as dependências
RUN npm ci --only=production --legacy-peer-deps

COPY . .
RUN npm run build

EXPOSE 1337

CMD ["npm", "start"]
