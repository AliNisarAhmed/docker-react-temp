FROM node:16.4.1-alpine as  builder

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./

RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache

RUN npm install --silent
RUN npm install react-scripts -g --silent

COPY . ./

RUN npm run build



FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html


