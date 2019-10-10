#DOCKERFILE FOR maze/client
#Run the client

FROM debian:stretch-slim

# Update and install
RUN apt-get update && \
    apt-get install -y curl

# Set workingdir
WORKDIR client

# Copy the exiting files in script to containter /maze/client
COPY ./* /client/
COPY ./data/ /client/data/

# Change all .bashfiles to readable in dir /maze
RUN chmod +x ./*.bash

ENTRYPOINT ["/bin/bash"]
# ENTRYPOINT ["/bin/bash", "-c"]
# CMD ["bash mazerunner.bash"]

# CMD ["bash mazerunner.bash init "]
# CMD ["bash mazerunner.bash maps"]