# Bashscript to run in dev mode.
# kmom10
 

# Create network
# sudo docker network create dbwebb

# # BYGGER IMAGES

sudo docker build --rm -t jeneljenel/vlinux-kmom10:server server/
sudo docker build --rm -t jeneljenel/vlinux-kmom10:client client/

# # Kör containers
# sudo docker run --rm -d -p 8080:1337 --name myserver --net dbwebb jeneljenel/vlinux-kmom10:server
# sudo docker run -it --rm  --name myclient --net dbwebb jeneljenel/vlinux-kmom10:client


#KILL the server
#KILL the network
# sudo docker kill myserver 
# sudo docker network rm dbwebb