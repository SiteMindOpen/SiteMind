#
#
# 1. program executables

password(){  # creates a password unless one has been received from user input
        if [ -z $PASSWORD ]
                then
                        PASSWORD=$(openssl rand -base64 24)
        fi
}

user_creation(){ # makes the entries in the system for the new user
        htpasswd -bB /etc/apache2/.htpasswd $USERNAME $PASSWORD

}

backup_conf(){
	TIMESTAMP=$(date +'%s')
	cp /etc/apache2/sites-available/000-default.conf /tmp/000-default-"$TIMESTAMP".conf
	cp /etc/apache2/sites-available/000-default-le-ssl.conf /tmp/000-default-le-ssl-"$TIMESTAMP".conf
}

header_ssl(){
	echo -e "<IfModule mod_ssl.c>"
	echo -e "<VirtualHost *:443>"
}

header_nossl(){
        echo -e "<VirtualHost *:80>"
}

header_common(){ # builds the header part of the apache conf file
	echo -e "        ServerAdmin webmaster@localhost"
	echo -e "        DocumentRoot /var/www/html"
	echo -e "        ErrorLog \${APACHE_LOG_DIR}/error.log"
	echo -e "        CustomLog \${APACHE_LOG_DIR}/access.log combined"
	echo -e ""
}

entries(){ # rebuilds the entries including the new entry
        cat /etc/apache2/.htpasswd | cut -d: -f1 > a2conf.temp
        while read USERNAME2
                do
                        echo -e "        <Directory \"/var/www/html/"$USERNAME2"\">"
                        echo -e "                AuthType Basic"
                        echo -e "                AuthName \"Website Intelligence login\""
                        echo -e "                AuthUserFile /etc/apache2/.htpasswd"
                        echo -e "                Require user "$USERNAME2""
                        echo -e "        </Directory>"
                        echo -e ""
                done <a2conf.temp
        }

footer_nossl(){ # builds the footer portion of the apache conf file
	echo -e "RewriteEngine on"
	echo -e "RewriteCond %{SERVER_NAME} =sitemind.io"
	echo -e "RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,QSA,R=permanent]"
        echo -e "</VirtualHost>"
}

footer_ssl(){
	echo -e "SSLCertificateFile /etc/letsencrypt/live/sitemind.io/fullchain.pem"
	echo -e "SSLCertificateKeyFile /etc/letsencrypt/live/sitemind.io/privkey.pem"
	echo -e "Include /etc/letsencrypt/options-ssl-apache.conf"
	echo -e "ServerName sitemind.io"
	echo -e "</VirtualHost>"
	echo -e "</IfModule>"
}

sync(){
	rsync -a "$TARGET"/mikko/ "$TARGET"/"$USERNAME"/;
        chown -R www-data:www-data "$NEW" && chmod -R g+rw "$NEW";
}

finish(){ # cleans up
        rm a2conf.temp
	rm $NEW/scorecard.html $NEW/overview.html $NEW/traffic.html $NEW/upstream.html $NEW/blacklist.html $NEW/whois.html;
}

#
#
# 2. execution executable

ssl_conf(){
	header_ssl
	header_common
	entries
	footer_ssl
}

nossl_conf(){
	header_nossl
	header_common
	entries
	footer_nossl
}

run_one(){
        # creating the new user
        password
        user_creation
	backup_conf

	nossl_conf
	
	sync
}

run_two(){
	ssl_conf
	finish
}

#
#
# 3. program execution

NOSSL_TARGET=/etc/apache2/sites-available/000-default.conf
SSL_TARGET=/etc/apache2/sites-available/000-default-le-ssl.conf

USERNAME=$1
PASSWORD=$2

TARGET=(/var/www/html);
NEW=$(echo -e "$TARGET/$USERNAME");

run_one > $NOSSL_TARGET
run_two > $SSL_TARGET

systemctl reload apache2

echo $PASSWORD
