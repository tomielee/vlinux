#DOCKERFILE FOR maze2/client
#Run the client

FROM debian:stretch-slim

# Update and install
RUN apt-get update && \
    apt-get install -y curl

# Set workingdir
WORKDIR client

# Copy the exiting files in script to containter /maze/client
COPY ./mazerunner.bash /client/mazerunner.bash

# Change mazerunner to be readable
RUN chmod +x ./mazerunner.bash

# Create folder data and make the folder writewbale
RUN mkdir /client/data/
RUN chmod +x ./data/

ENTRYPOINT ["/bin/bash"]
CMD ["mazerunner.bash", "loop"]