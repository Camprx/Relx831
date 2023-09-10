FROM node:latest
EXPOSE 80
WORKDIR /app

COPY entrypoint.sh /app/
COPY package.json /app/
COPY index.js /app/


RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    npm install -g pm2

ENTRYPOINT [ "node", "index.js" ]
