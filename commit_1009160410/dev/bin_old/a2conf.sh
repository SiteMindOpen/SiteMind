USERNAME=$1

header(){
echo -e "<VirtualHost *:80>"
echo -e "        ServerAdmin webmaster@localhost"
echo -e "        DocumentRoot /var/www/html"
echo -e "        ErrorLog ${APACHE_LOG_DIR}/error.log"
echo -e "        CustomLog ${APACHE_LOG_DIR}/access.log combined"
echo -e ""
}

usernames(){
        PASSWORD=$(openssl rand -base64 24)
        htpasswd -bB /etc/apache2/.htpasswd $USERNAME $PASSWORD

        cat /etc/apache2/.htpasswd | cut -d: -f1 > a2conf.temp

        while read USERNAME
                do
                        echo -e "        <Directory "/var/www/html/"$USERNAME"">"
                        echo -e "                AuthType Basic"
                        echo -e "                AuthName '""Website Intelligence login""'"
                        echo -e "                AuthUserFile /etc/apache2/.htpasswd"
                        echo -e "                Require user "$USERNAME""
                        echo -e "        </Directory>"
                        echo -e ""

		done <a2conf.temp
        }

footer(){
        echo -e "</VirtualHost>"
}

finish(){
        rm a2conf.temp
	echo $PASSWORD
}

run(){
        header
        usernames
        footer
}


TARGETFILE=/etc/apache2/sites-available/000-default.test

        mkdir /var/www/html/"$USERNAME"
        chown www-data:www-data /var/www/html/"$USERNAME"

run > $TARGETFILE
USERTEMP=$USERNAME
finish
