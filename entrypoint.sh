#!/bin/bash
# set -e


# instalar apache2 y git
apt update && apt install apache2 git -y


if test -d /tpfinal;then
	
	# esto se ejecuta siempre que la condicion devuelva true.
	cd /tpfinal && git pull
else
	# esto se ejecuta siempre que la condicion devuelva false.
	git clone https://github.com/pexcadito/tpfinal /tpfinal 
fi



cd /tpfinal && git checkout v2.0

cp /tpfinal/apache2.conf /etc/apache2/

cp /tpfinal/000-default.conf /etc/apache2/sites-available/

sed -i 's/titulo/'"$NAME"'/' /tpfinal/html/index.html


exec "$@" 


