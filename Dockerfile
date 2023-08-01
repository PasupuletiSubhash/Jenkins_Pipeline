FROM ubuntu:latest
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -y \
    && apt install wget mariadb-server tzdata -y \
    && apt install unzip php apache2 php-mysqlnd -y \
    && wget https://wordpress.org/latest.zip \
    && rm -rf /var/www/html/* \
    && unzip latest.zip -d /var/www/html/ \
    && mv /var/www/html/wordpress/* /var/www/html/ \
    && mv /var/www/html/wp-config-sample.php  /var/www/html/wp-config.php

COPY wp-config.php /var/www/html

EXPOSE 3306
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
