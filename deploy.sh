#!/bin/bash

# Ruta a tu proyecto en el servidor
DEPLOY_PATH=/var/www/html/my-web-app

# Copia los archivos actualizados
scp -r * ubuntu@172.16.101.128:$DEPLOY_PATH

# Conéctate al servidor y reinicia NGINX
ssh usuario@tu_servidor_ubuntu "sudo systemctl restart nginx"
