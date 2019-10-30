#DOCKERFILE FOR bthloggen/client
#Run the client

FROM debian:stretch-slim

# Update and install
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y jq

# Set workingdir
WORKDIR client

# Copy the exiting files in script to containter /bthloggen/client
COPY ./bthloggen.bash /client/bthloggen.bash
COPY ./server.txt /client/server.txt

# Change the bashscript to be readable
RUN chmod +x ./bthloggen.bash
RUN chmod +x ./server.txt

#create and change
# RUN touch ./server.txt
# RUN chmod +x ./server.txt 
# CMD ["localhost > server.txt"]

ENTRYPOINT ["/bin/bash"]