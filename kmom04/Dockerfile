FROM node:8

WORKDIR /server

COPY server/package*.json ./

RUN npm install

#To run dev mode nodemon
RUN npm install -g nodemon

COPY server/ .

# check package.json in /server. 
CMD [ "npm", "start" ]

# FROM node:8 talar om att vi vill använda imagen node med taggen 8. Den laddas ned automatiskt om den inte finns.
# WORKDIR /server talar om att vi vill använda mappen server/ som startläge i containern. Allt vi gör efter utgår från den mappen.
# COPY package*.json ./ kopierar in alla filer vars namn börjar med package och slutar med .json och lägger dem i arbetsmappen.
# RUN npm install kör kommandot som använder package.json och installerar det som behövs, i detta fallet Express.
# COPY server/ . kopierar in innehållet i mappen server/ till arbetsmappen.
# CMD [ “npm”, “start” ] kör kommandot som startar servern när containern bootas upp.