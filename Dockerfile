FROM node:16 as builder
USER node
RUN mkdir /home/node/app && chown node:node /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node package.json .
RUN npm i
COPY --chown=node:node . .
RUN npm run build

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
