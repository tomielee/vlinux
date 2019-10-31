#DOCKERFILE FOR bthloggen/server
#Start the server

FROM node:8

# Set workingdir
WORKDIR server

COPY package*.json ./

RUN npm install
RUN npm install -g nodemon


# Copy the exiting files in server/ to containter /bthloggen/server
COPY ./ /server/


# Start the server
CMD [ "node", "index.js" ]

