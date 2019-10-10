FROM debian:stretch-slim

# Set workingdir
WORKDIR script

# Copy the exiting files in script to containter /kmom3/
COPY script/ /kmom03/

# Change all .bashfiles to readable in dir /script
RUN chmod +x /kmom03/*.bash

# Install packages for calendar
RUN apt-get update
RUN apt-get install bsdmainutils

# # Build an own image namned first, tag version1
# #
# docker build -t first:version1 

#CMD ["bash", "/kmom03/commands.bash"]

ENTRYPOINT ["/bin/bash", "-c", "/kmom03/commands.bash all"]
