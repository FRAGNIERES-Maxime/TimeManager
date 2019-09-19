Piscine MSC1




#A faire a chaque update du projet 

sudo docker-compose build 


#Lancer Docker 

sudo docker-compose up

#regarde ta console pour l'ip/le port du front


#Lancer le back ( hors docker )


cd Mini_Projet_1

sudo systemctl start postgresql

mix deps.get

(mix ecto.create) #Si la db n'est pas encore initialisé 

mix ecto.migrate

mix phx.serv

#Lancer le front ( hors docker )

npm install

npm run dev 

##Commande utile

#acces de VM de l'image

sudo docker exec -it <NOM DE L'IMAGE> hash 
