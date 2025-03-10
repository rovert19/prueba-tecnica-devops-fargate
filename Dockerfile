# Build stage
FROM node:20.18-alpine as build

WORKDIR /app

COPY ./web-page-deploy-devops .

RUN npm install

RUN npm run build

# Production stage
FROM nginx:stable-alpine as production

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]