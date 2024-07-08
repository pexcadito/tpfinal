TP Final - Mi App

Este repositorio contiene los pasos y configuraciones necesarios para la creación y despliegue de la aplicación **Mi App** utilizando Docker.

## Creación de la Imagen Docker

### Clonar Repositorio

$ git clone https://github.com/pexcadito/tpfinal

$ cd tpfinal

Construcción de la Imagen

Asegúrate de estar en la rama correcta (main, develop, testing) antes de construir la imagen.

$ docker build -t tpfinal .

Verifica que la imagen se haya creado correctamente.

$ docker images

Creación y Montaje de un Volumen

Verifica las unidades disponibles en el disco.

$ lsblk

Si no tienes un dispositivo /dev disponible, puedes crear uno virtualmente:

$ dd if=/dev/zero of=tpfinal.img bs=1M count=1024

$ mkfs.ext4 tpfinal.img

$ mkdir /mnt/tpfinal

$ mount tpfinal.img /mnt/tpfinal

$ lsblk

Creación del Contenedor Docker con Volumen Montado

$ docker run -d -p 80:80 --name miapache -v /mnt/tpfinal:/var/www/html/ httpd

Verifica la IP del contenedor para acceder a la URL, cual han colocado.

Modificación y Copia de Archivos

Crer un archivo index.html en el directorio a montar.

Modifica el archivo index.html en el directorio montado (/mnt/tpfinal) y cópialo al contenedor.

$ docker cp /mnt/tpfinal/index.html miapache:/var/www/html/index.html

Accede al contenedor para modificar el archivo de configuración si es necesario.

$ docker exec -it miapache bash

$ nano /usr/local/apache2/conf/httpd.conf

Una vez modificado, copia nuevamente el index.html al directorio correcto.

$ docker cp /mnt/tpfinal/index.html miapache:/var/www/html/index.html

Configuración del Proxy
Crea un archivo de configuración para el proxy, por ejemplo, mi-app.conf.



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

