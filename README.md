# SiteMind Open Source Website Intelligence 

The following installation instructions have been tested on Ubuntu 14.04 clean distro. 

##### Install dependencies

	sudo apt-get update
	sudo apt-get install -y apache2
	sudo apt-get install -y php5 
	sudo apt-get install -y unzip
	sudo apt-get install -y parallel 
	sudo apt-get install -y num-utils
	sudo apt-get install -y git 

##### Getting the files and setting it up

	wget https://github.com/SiteMindOpen/SiteMind/archive/master.zip
	unzip master.zip
	sudo rsync -av ~/SiteMind-master/ /var/www/html

	chown -R www-data:www-data /var/www/html && chmod -R g+rw /var/www/html

After the initial setup, as long as you create new users with SiteMind command line command 'sm-user-new', permissions will be handled automatically and is not something you need to think about. 

##### Creating an admin user

	PASSWORD=$(openssl rand -base64 20); htpasswd ./etc/apache2/.htpasswd -cbB admin "$PASSWORD"; echo -e "Your password is $PASSWORD";

##### Restart apache

Ubuntu 14.04:
    
    service apache2 restart

Ubuntu 16.04: 

    systemctl apache restart


##### Setup https with letsencrypt 

Letencrypt makes it incredibly easy (and fast) to setup functional https for your site. 

Note that for the below to work, you need to have a valid domain name that is pointed to the server you're initiating the below command from:

	sudo git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
	cd /opt/letsencrypt
	./letsencrypt-auto --apache -d yoursite.com

NOTE: as part of the setup process, there will be a prompt asking if you want to redirect all requests to https. I think this should be on for most cases.


##### Environment variables for SiteMind

Add the following lines to your .bashrc file. 

    alias sm-sync='/var/www/html/admin/bin/backup.sh'
    alias sm-user-list='cat /etc/apache2/.htpasswd | cut -d: -f1'
    alias sm-monitor='/var/www/html/admin/bin/monitor.sh'
    alias sm-user-new='/bin/newuser.sh'
    alias sm-user-rm='/var/www/html/admin/bin/removeuser.sh'
    alias sm-commit='/var/www/html/admin/bin/commit.sh'

Learn more about the admin command line features here: 

https://github.com/SiteMindOpen/SiteMind/blob/master/admin/README.md


