# imagen base
FROM ubuntu

# exponer puertos del contenedor
EXPOSE 80 443


# copiar entrypoint al raiz
COPY entrypoint.sh /entrypoint.sh

# permisos de ejecución
RUN chmod +x /entrypoint.sh

# indicar cual es el entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# los argumentos que se le pasan al script entrypoint.sh
CMD ["apache2ctl", "-D", "FOREGROUND"]


