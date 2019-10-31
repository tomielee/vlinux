#DOCKERFILE FOR bthloggen/server
#Start the server

FROM node:8

# Set workingdir
WORKDIR /server

COPY package*.json ./

RUN npm install

# Copy the exiting files in server/ to containter /bthloggen/server
# COPY ./ /server/
COPY ./ . 

# Start the server
CMD [ "node", "index.js" ]

