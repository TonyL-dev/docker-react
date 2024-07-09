FROM node:16-alpine as builder 
# everything will be referred to as the builder phase
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# we want to copy over to /app/build

FROM nginx
# for Docker, this instruction does nothing, for Elastic Beanstalk this is a port mapping
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# don't need to run anything because the default NGINX command is start