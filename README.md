# Discord Updater

- Script personnel développé pour mettre à jour Discord sous Linux

---
# Préréquis

- `chmod u+x discord_updater.sh` pour pouvoir executer le script
- Une archive `.tar.gz` de Discord sous la forme `discord-....tar.gz` dans votre dossier Téléchargements
- Le programme est conçu en partant du principe que le dossier de Discord est installé dans `/opt`

---
# Utilisation

- `sudo ./discord_updater.sh` permet de lancer le script. Une condition a été écrite pour exécuter ce programme en tant qu'Administrateur.
- Ce script désinstalle votre version existante de Discord, décompresse l'archive téléchargée, et déplace son contenu vers le répertoire d'installation : `/opt`.
- Pour une utilisation épurée, tout dossier temporaire créé pendant le script ainsi que l'archive utilisée sont supprimées en fin de script.
- Une fonction de debug a été intégrée au programme afin qu'en cas d'erreur d'exécution, l'utilisateur puisse savoir jusqu'à où l'installation s'est bien déroulée et ou elle a échoué.
