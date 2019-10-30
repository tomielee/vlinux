#DOCKERFILE FOR bthloggen/server
#Start the server

FROM node:8

# RUN npm install

# Set workingdir
WORKDIR server

# Copy the exiting files in server/ to containter /bthloggen/server
COPY ./ /server/


# Start the server
CMD [ "node", "index.js" ]

