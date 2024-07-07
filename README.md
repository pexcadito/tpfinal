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
$ cd mi-app
```

#### Creación de imagen

```
$ docker build -t mi-app-v1 .
```

> Nota: Antes de construir la imagen posicionarse en la rama correspondiente (main, develop, testing).

Una vez terminado comprobamos si la imagen se ha creado.

# docker images
---

Ahora procedemos a crear el contenedor.
Vamos a utilizar el comando

# docker run -d -p 80:80 mi-app

