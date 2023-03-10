FROM node:19-alpine as builder

ENV REACT_APP_API_URL=%%REACT_APP_API_URL%%

WORKDIR /app

COPY ./package.json ./package-lock.json ./
RUN npm install

COPY ./ ./
RUN npm run build

FROM nginx:1.21-alpine

RUN apk add --no-cache curl

COPY ./docker/production/nginx/conf.d /etc/nginx/conf.d
COPY ./docker/production/nginx/docker-entrypoint-env.sh /
RUN chmod +x /docker-entrypoint-env.sh

ENTRYPOINT ["/docker-entrypoint-env.sh"]
CMD ["nginx", "-g", "daemon off;"]

WORKDIR /app

COPY --from=builder /app/dist ./public

HEALTHCHECK --interval=5s --timeout=3s --start-period=1s CMD curl --fail http://127.0.0.1/health || exit 1