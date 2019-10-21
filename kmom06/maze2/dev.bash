# Bashscript to run in dev mode.
# kmom06
 
# CREATE NETWORK
# with name dbwebb
# # Decomment kill the server it you run the network.
# sudo docker network create dbwebb

# # BYGGER IMAGE 
# Build when only when you have to!!! (local in dev mode...)
# The images are on dockerhub so they will build from the hub. 
sudo docker build --rm -t jeneljenel/vlinux-mazeserver server/
sudo docker build --rm -t jeneljenel/vlinux-mazeclient:loop client/


#KILL the server
#KILL the network
# sudo docker kill myserver 
# sudo docker network rm dbwebb