FROM node:20-alpine AS build

WORKDIR /app

COPY package.json .
COPY tsconfig* .
COPY index.html .
COPY vite.config.ts .

RUN yarn 

COPY ./public ./public
COPY ./src ./src

RUN yarn build


# FROM nginxinc/nginx-unprivileged:1.27-alpine-slim

# ARG UID=2001
# ARG GID=2001

# COPY --chown=${UID}:${GID} --from=build /app/dist /usr/share/nginx/html/

FROM alpine

COPY --chown=${UID}:${GID} --from=build /app/dist /app/dist