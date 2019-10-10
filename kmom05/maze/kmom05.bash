# Skapa ett exekverbart Bash-skript, maze/kmom05.bash. Skriptet ska göra följande:

# Klient-kontainern ska starta i Bash och i den arbetsmappen du har skriptet i.
 
# Skapa ett nätverk med namet dbwebb.
sudo docker network create dbwebb

# # BYGGER IMAGE
sudo docker build --rm -t jeneljenel/vlinux-mazeserver server/
sudo docker build --rm -t jeneljenel/vlinux-mazeclient client/

# Starta upp båda kontainrarna med rätt options.
# Servern ska även kunna nås via webbläsaren. * -p 8080
# Båda kontainrarna ska ha egna namn. * --name
# # servernamnet * --network-alias
# Server-kontainern ska köras i bakgrunden. * -d de
sudo docker run --rm -d -p 8080:1337 --name myserver --network-alias myserver --net dbwebb jeneljenel/vlinux-mazeserver:latest

# Klienten ska använda serverns namn. * curl myserver i mazerunner.bash
# Du behöver då byta ut “localhost” i skriptet mot namnet du ger servern.
sudo docker run -it --rm  --name myclient --net dbwebb jeneljenel/vlinux-mazeclient:latest

# Stoppa den/de kontainrar som är igång och ta bort nätverket.
sudo docker kill myserver 
sudo docker network rm dbwebb