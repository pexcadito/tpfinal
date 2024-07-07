# TP Dockerfile

## Mi App

Dockerfile para la creacion y despliegue de la aplicacion **Mi App**.



### Creación de la imagen

#### Clonar repositorio

```
$ git clone https://gitlab.com/infra-miercoles-1er-2024/mi-app.git
```

 Una vez clonado el repo acceder al directorio.

```
$ cd mi-app
```

#### Creación de imagen

```
$ docker build -t mi-app-v1 .
```

> Nota: Antes de construir la imagen posicionarse en la rama correspondiente (main, develop, testing).

#### Despliegue del contenedor

Mediante comandos Docker.

```
$ docker run -d -e NAME="Mi App" -p 8000:80 --name mi-app mi-app-img
```
