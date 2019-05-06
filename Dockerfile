FROM php:7.3.5-apache
ARG HTTP_PROXY
RUN echo "Acquire::http::Proxy \"${HTTP_PROXY}\";" >> /etc/apt/apt.conf

# Postgresql: libpq-dev
# EXIF: imagemagick
# GD: libpng-dev libfreetype6-dev libjpeg-dev
# ZIP: libzip-dev unzip zlib1g-dev
# AD: libldap2-dev
RUN apt-get update && apt-get install -y libpq-dev libzip-dev libldap2-dev unzip rsync zlib1g-dev imagemagick libpng-dev libjpeg-dev libfreetype6-dev
RUN ldconfig && ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
#RUN docker-php-ext-install pgsql pdo pdo_pgsql ldap zip exif gd && docker-php-ext-enable pgsql pdo pdo_pgsql ldap zip exif gd
RUN docker-php-ext-install pgsql pdo pdo_pgsql ldap zip exif gd

# postgresql-client for pg_dump
RUN mkdir -p /usr/share/man/man1 && mkdir -p /usr/share/man/man7
RUN  apt install -y postgresql-client

# install php composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# for yooutube-dl
RUN apt-get install -y python
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl
RUN export LC_ALL=C && youtube-dl -U

RUN rm -rf /var/lib/apt/lists/*
#RUN rm /etc/apt/apt.conf

COPY apache2-foreground /usr/local/bin/

EXPOSE 80 443
CMD ["apache2-foreground"]
