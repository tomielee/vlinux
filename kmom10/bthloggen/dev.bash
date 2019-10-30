# Bashscript to run in dev mode.
# kmom10
 


# # BYGGER IMAGE 

sudo docker build --rm -t jeneljenel/vlinux-kmom10:server server/
sudo docker build --rm -t jeneljenel/vlinux-kmom10:client client/


#KILL the server
#KILL the network
# sudo docker kill myserver 
# sudo docker network rm dbwebb