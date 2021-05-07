################# STAGE 1 #################

FROM alpine/git as clone
LABEL "author"="Nitin"
WORKDIR /app
RUN git clone https://github.com/imnitin28/foss-events.git

################# STAGE 2 ##################

#ARG VERSION=stretch-slim
FROM node:stretch-slim as build
WORKDIR /app
COPY --from=clone /app/foss-events/ /app
COPY package*.json ./
RUN npm install

################# STAGE 3 ###################

FROM build as finalstage
COPY --from=build . . 
WORKDIR /app
EXPOSE 3000
CMD ["npm", "start"]