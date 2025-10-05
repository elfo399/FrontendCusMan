# ==========================
# 1️⃣ BUILD STAGE
# ==========================
FROM node:22 AS build

# Imposta la cartella di lavoro
WORKDIR /app

# Copia i file di configurazione e installa le dipendenze
COPY package*.json ./
RUN npm install

# Copia il resto del progetto Angular
COPY . .

# Compila l'app per la produzione
RUN npm run build 

# ==========================
# 2️⃣ RUNTIME STAGE
# ==========================
FROM nginx:alpine

# Copia i file buildati nel path servito da Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Espone la porta 80
EXPOSE 80

# (opzionale) personalizza il file di configurazione di Nginx
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Avvia Nginx
CMD ["nginx", "-g", "daemon off;"]
