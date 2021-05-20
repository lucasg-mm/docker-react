# ----BUILD PHASE-----
FROM node:alpine
USER node
RUN mkdir -p /home/node/app 
WORKDIR "/home/node/app"
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

# ------RUN PHASE-------
FROM nginx
COPY --from=0 /home/node/app/build /usr/share/nginx/html
