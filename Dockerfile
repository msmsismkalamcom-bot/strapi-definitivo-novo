FROM node:18-alpine

WORKDIR /app

# Copie arquivos de configuração
COPY package*.json ./
COPY .npmrc ./

# Instale dependências
RUN npm config set legacy-peer-deps true
RUN npm ci --only=production --legacy-peer-deps

# Copie o código
COPY . .

# Crie favicon se não existir
RUN mkdir -p public && if [ ! -f public/favicon.ico ]; then \
    echo -e '\x00\x00\x01\x00\x01\x00\x10\x10\x00\x00\x00\x00\x00\x00\x28\x01\x00\x00\x16\x00\x00\x00\x28\x00\x00\x00\x10\x00\x00\x00\x20\x00\x00\x00\x01\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\xFF\xFF\x00' > public/favicon.ico; \
    fi

# Build
RUN npm run build

EXPOSE 1337

CMD ["npm", "start"]
