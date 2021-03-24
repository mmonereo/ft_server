#!/bin/bash

#ssl config
openssl req -x509 -newkey rsa:4096 -nodes -days 365 -keyout /etc/ssl/private/ca-key.pem -out /etc/ssl/certs/ca-cert.pem -subj "/C=SP/ST=Madrid/L=Madrid/O=42/CN=127.0.0.1/emailAddress=mmonereo@student.42.fr"
openssl req  -newkey rsa:4096 -nodes -keyout /etc/ssl/private/server-key.pem -out /etc/ssl/certs/server-req.pem -subj "/C=SP/ST=Madrid/L=Madrid/O=42/CN=127.0.0.1/emailAddress=mmonereo@student.42.fr"
openssl x509 -req -in /etc/ssl/certs/server-req.pem -CA /etc/ssl/certs/ca-cert.pem -CAkey /etc/ssl/private/ca-key.pem -CAcreateserial -out /etc/ssl/certs/server-cert.pem

#nginx config
mkdir /var/www/localhost
mv /tmp/srcs/index.html /var/www/localhost
mv /tmp/srcs/localhost /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-enabled/default
rm -rf /var/www/html

#phpMyAdmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz
tar xvf phpMyAdmin-5.1.0-english.tar.gz -C /var/www/localhost/
mv /var/www/localhost/phpMyAdmin-5.1.0-english/ /var/www/localhost/phpmyadmin/
mv /tmp/srcs/config.inc.php /var/www/localhost/phpmyadmin/
rm -rf phpMyAdmin-5.1.0-english.tar.gz

#database mysql for wp
service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root

#wordpress
tar xvf /tmp/srcs/wordpress-5.7.tar.gz -C /var/www/localhost/
mv /tmp/srcs/wp-config.php /var/www/localhost/wordpress

#grant permissions
chown -R www-data:www-data /var/www/localhost
chmod -R 755 /var/www/localhost

#start services
service mysql restart
service php7.3-fpm start
service nginx start


 # docker build -t demo .
 # docker run --name tapa -d -p 80:80 -p 443:443 demo
 # docker exec -it  tapa bash

