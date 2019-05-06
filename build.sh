http_proxy=http://10.32.26.106:3128
VERSION=7.3.5
docker build -t swordhuang/php:$VERSION-apache-postgresql --build-arg HTTP_PROXY=$http_proxy .
docker push swordhuang/php:$VERSION-apache-postgresql
docker push swordhuang/php:latest 
