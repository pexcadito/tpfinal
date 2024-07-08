# TP Dockerfile

## Mi App

Dockerfile para la creacion y despliegue de la aplicacion **Mi App**.



### Creación de la imagen

#### Clonar repositorio

```
$ git clone https://github.com/pexcadito/tpfinal
```

 Una vez clonado el repo acceder al directorio.

```
$ cd tpfinal
```

#### Creación de imagen

```
$ docker build -t tpfinal .
```

> Nota: Antes de construir la imagen posicionarse en la rama correspondiente (main, develop, testing).

Una vez terminado comprobamos si la imagen se ha creado.

# docker images
---

Ahora procedemos a crear el contenedor.
Vamos a utilizar el comando

# docker run -d -p 80:80 tpfinal
---
Lo que haremos ahora es dar formato y montar en un volumen “x”
Verificamos el disco las unidades:
# lsblk
---
En caso de no tener un dispositivo DEV para el montaje, podemos utilizar uno virtual, haciendo lo siguiente:

# dd if=/dev/zero of=tpfinal.img bs=1M count=1024
(tpfinal.img, es el que utilizamos nosotros)
--	
Ahora le damos formato al mismo.

# mkfs.ext4 tpfinal.img
--
Ahora vamos a crear un punto de directorio para el montaje del mismo.
# mkdir /mnt/tpfinal

Y ahora montamos el archivo IMG con en la carpeta especificada.

# mount tpfinal.img /mnt/tpfinal

Y con el comando siguiente vemos la unidad, vemos la unidad.

# lsblk
--
Ahora vamos crear el contenedor Docker con el volumen montado

# docker run -d -p 80:80 --name miapache -v /mnt/tpfinal:/var/www/html/ httpd
Y comprobamos con la ip del nuestro contenedor acceder a la URL
---
Ahora vamos a crear el archivo CSS muy muy básico para el index.html y asi modificar y agregarlo al contenedor.

# docker cp /mnt/tpfinal/index.html miapache2:/usr/local/apache2/htdocs/index.html

Vemos aquí, que el directorio es otro, pero vamos a modificar el archivo de configuración para que nos tome la que nos indicaron: /var/www/html

Accedemos al docker

# docker exec -it miapache2 bash
Despues accedemos al archivo de configuración y modificamos el directorio del mismo.

# nano /usr/local/apache2/conf/httpd.conf
---
Una vez modificado, modificamos el index.html, en el directorio de mount que hemos creado, como lo tenemos ya modificado, lo copiamos utilizando lo siguiente:

# docker cp /mnt/tpfinal/index.html miapache2:/var/www/html/index.html

Por ultimo creamos el archivo con la configuración del proxy y asi agregarlo con su instalador.

En este caso creamos mi-app.conf

server {
    listen 80;
    server_name tpfinal.com;

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://ip_docker_server:8000;
    }
}

