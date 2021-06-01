FROM debian:buster
LABEL maintainer="<mmonereo@student.42.fr>"
ENV AUTOINDEX on
RUN apt-get update
RUN apt-get install -y \
wget \
php-fpm \
php-mysql \
php-xml \
mariadb-server \
nginx 
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY srcs/ /tmp/srcs/
EXPOSE 80 443
CMD  bash /tmp/srcs/init.sh
