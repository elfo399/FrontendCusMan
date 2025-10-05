# ==========================
# 1️⃣ BUILD STAGE
# ==========================
FROM node:22 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# ==========================
# 2️⃣ RUNTIME STAGE
# ==========================
FROM nginx:alpine

# Copia la build Angular nel path servito da Nginx
COPY --from=build /app/dist/cusman-frontend /usr/share/nginx/html

EXPOSE 80

# (opzionale) nginx personalizzato per routing Angular
# COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
