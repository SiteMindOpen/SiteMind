#!/bin/bash

## F U N C T I O N S

create_user(){
	PASSWORD=$(openssl rand -base64 20); 
	htpasswd -bB /etc/apache2/.htpasswd "$USERNAME" "$PASSWORD"; 
	echo -e "Your password is $PASSWORD";
}

backup(){
	TIMESTAMP=$(date +'%s')
	cp /etc/apache2/sites-available/000-default-le-ssl.conf /tmp/000-default-le-ssl-"$TIMESTAMP".conf
}


header(){
	head -7 /etc/apache2/sites-available/000-default-le-ssl.conf
}

entry(){
	echo -e "	"
	echo -e "        <Directory \"/var/www/html/sitemind/"$USERNAME"\">"
	echo -e "                AuthType Basic"
	echo -e "                AuthName \"Method Media Intelligence - Sitemind Login\""
	echo -e "                AuthUserFile /etc/apache2/.htpasswd"
	echo -e "                Require user "$USERNAME""
	echo -e "        </Directory>"
	echo -e "	"
}

footer(){
	sed '1,8d' /etc/apache2/sites-available/000-default-le-ssl.conf
}

update_conf(){
	rm /tmp/apache_conf_file.temp
	header >> /tmp/apache_conf_file.temp
	entry >> /tmp/apache_conf_file.temp
	footer >> /tmp/apache_conf_file.temp	
}

apache_conf(){
	sudo apachectl configtest
	sudo service apache2 restart
}

sitemind_package(){
	rsync -avq ~/sitemind-master/ /var/www/html/sitemind/"$USERNAME"
}

## P R O G R A M   S T A R T S
	
	USERNAME=$1
	
	create_user
	backup
	update_conf
 
	cp /tmp/apache_conf_file.temp /etc/apache2/sites-available/000-default-le-ssl.conf

	apache_conf

	sitemind_package
