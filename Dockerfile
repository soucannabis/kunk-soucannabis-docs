# Site estático Astro + Starlight (docs do Kunk).
ARG NODE_VERSION=22
FROM node:${NODE_VERSION}-bookworm-slim AS build

WORKDIR /app

COPY package.json package-lock.json* ./
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi

COPY . .
RUN npm run build

FROM nginx:1.27-alpine AS runtime

RUN apk add --no-cache gettext \
  && rm -f /etc/nginx/conf.d/default.conf

COPY deploy/nginx.conf.template /etc/nginx/templates/default.conf.template
COPY deploy/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY --from=build /app/dist /usr/share/nginx/html

ENV PORT=8080 \
    KUNK_API_PUBLIC_HOST=kunk-api-production.up.railway.app

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
