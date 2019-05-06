# php-apache-postgresql-dockerfile

pwd=`pwd`

# Postgresql
docker run --restart always --name postgres -it  -d -v $pwd/data/db/data:/var/lib/postgresql/data -v $pwd/data/db/tmp:/tmp -e POSTGRES_PASSWORD=passwd postgres

# Apache + PHP
docker run -d --restart always -p 1080:80 --link postgres:postgres --name php -v $pwd/data/php/html:/var/www/html -v $pwd/data/php/php.ini:/usr/local/etc/php/php.ini -v $pwd/data/php/log:/var/log/apache2 swordhuang/php:7.2.10-apache-post




