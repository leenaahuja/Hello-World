#Prepare Build
FROM node:12 as build-env
WORKDIR /build
COPY . .
RUN npm install
RUN npm prune --production

#Prepare Image for Deployment
FROM node:12-alpine as runner
COPY --from=build-env /build /nodeserver
WORKDIR /nodeserver
EXPOSE 8085
ARG ENV=production
ENV NODE_ENV $ENV
CMD npm run $NODE_ENV