FROM node:20-alpine AS builder

WORKDIR /squadra-web-front

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build


FROM nginx:alpine AS runner

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /squadra-web-front/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]