#!/bin/bash
# set -e


# instalar apache2 y git
apt update && apt install apache2 git -y


if test -d /app;then
	
	# esto se ejecuta siempre que la condicion devuelva true.
	cd /app && git pull
else
	# esto se ejecuta siempre que la condicion devuelva false.
	git clone https://gitlab.com/infra-miercoles-1er-2024/mi-app.git /app 
fi



cd /app && git checkout v2.0

cp /app/apache2.conf /etc/apache2/

cp /app/000-default.conf /etc/apache2/sites-available/

sed -i 's/titulo/'"$NAME"'/' /app/html/index.html


exec "$@" 


