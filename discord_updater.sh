#!/bin/bash
if [ "$EUID" -ne 0 ] # Vérifie que l'utilisateur est en sudo pour outrepasser l'écriture de certains répertoires
then
	echo "Ce script doit être exécuté avec les privilèges sudo."
	exit 1
fi

check_error() { # Fonction appelée plusieurs fois dans le programme et permet de pouvoir débug en cas de soucis
	if [ $? -ne 0  ]
	then
		echo "Erreur sur la ligne $(( $1 - 1 )): $2"
		exit 1
	fi
}

real_user=$SUDO_USER # $SUDO_USER est une variable d'environnement stockant le nom d'utilisateur lançant le script
download_path=$(sudo -u "$real_user" xdg-user-dir DOWNLOAD) # Définition du dossier source de l'archive, xdg-user-dir DOWNLOAD permet de récuperer de dossier de Téléchargements de l'utilisateur
echo -e "Chemin de l'archive : $download_path"
cd $download_path

archive=$(find $download_path -name "discord-*tar\.gz" | head -n 1) # Récupération de la première archive qui convient avec le paterne spécifié
if [[ -n $archive ]]
then
	echo -e "Archive trouvée : $archive"
else
	check_error $LINENO "Aucune archive trouvée"
fi

echo "Décompression de l'archive $archive"
tar -xzf $archive
check_error $LINENO "Erreur dans la décompression de l'archive"

cd /opt
echo "Suppression de la version actuelle de Discord"
rm -rf discord
mkdir discord

echo "Déplacement de la nouvelle version de Discord"
mv $download_path/Discord/* discord
check_error $LINENO "Erreur lors du déplacement de la nouvelle version"

echo "Rétablissement des liens symboliques"
ln -sf /opt/discord/Discord /usr/bin/discord
check_error $LINENO "Erreur lors du rétablissement des liens symboliques"

echo "Suppression de l'archive et du dossier temporaire"
rm -rf $archive
rm -rf $download_path/Discord
echo "Script Terminé sans erreur !"
