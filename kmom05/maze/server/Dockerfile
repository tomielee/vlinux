#DOCKERFILE FOR maze/server
#Start the server

FROM node:8

# RUN npm install

# Set workingdir
WORKDIR server

# Copy the exiting files in server/ to containter /maze/server
COPY ./ /server/



# Start the server
CMD [ "node", "index.js" ]

