FROM node:alpine
WORKDIR /public
RUN npm i -g http-server 	&& npm cache clean --force
EXPOSE 8080
CMD ["http-server"]
