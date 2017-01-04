# SiteMind Open Source Website Intelligence 

### WHAT IS IT

Domain research tool targeting media planners and reseaerchers, specifically built for countering ad fraud in media investment.

### FEATURE HIGHLIGHTS

- intuitive 'buy score' system for website rating
- search any domain
- returns result usually in 1 to 2 seconds
- up to 150 data points per site from 5 different sources
- easy to use API with ready end-points for all common languages

### CONTENTS OF THE PACKAGE 

Everything goes in to /var/www/html or whatever is your public html directory. 

There are a couple of new folders created...

/var/www/html/
	     /admin
	     /dev
	     /sitemind 

...together with their sub-folders.

Each subfolder has its own README.md file. The document root intentionally only contains the README.md file. 

/admin = where the admin functionality related scripts live

/dev = the dev instance (which is copied to user accounts)

/sitemind = main program folder where program scripts live

Again, when new users are created after installation, all such installations will be copies of /dev. Each user will have their own folder which is initially a replica of /dev. 

### GETTING STARTED 

The following installation instructions have been tested on Ubuntu 14.04 clean distro. 

#### Install dependencies

	sudo apt-get update
	sudo apt-get install -y apache2
	sudo apt-get install -y php5 
	sudo apt-get install -y unzip
	sudo apt-get install -y parallel 
	sudo apt-get install -y num-utils
	sudo apt-get install -y bc

If you plan to contribute to the code: 

	sudo apt-get install -y git 

#### Getting the files and setting it up

	wget https://github.com/SiteMindOpen/SiteMind/archive/master.zip
	unzip master.zip
	sudo rsync -av ~/SiteMind-master/ /var/www/html

	chown -R www-data:www-data /var/www/html && chmod -R g+rw /var/www/html

After the initial setup, as long as you create new users with SiteMind command line command 'sm-user-new', permissions will be handled automatically and is not something you need to think about. 

#### Creating an admin user

	PASSWORD=$(openssl rand -base64 20); htpasswd ./etc/apache2/.htpasswd -cbB admin "$PASSWORD"; echo -e "Your password is $PASSWORD";

#### Restart apache

Ubuntu 14.04:
    
    service apache2 restart

Ubuntu 16.04: 

    systemctl apache restart


#### Setup https with letsencrypt 

Letencrypt makes it incredibly easy (and fast) to setup functional https for your site. 

Note that for the below to work, you need to have a valid domain name that is pointed to the server you're initiating the below command from:

	sudo git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
	cd /opt/letsencrypt
	./letsencrypt-auto --apache -d yoursite.com

NOTE: as part of the setup process, there will be a prompt asking if you want to redirect all requests to https. I think this should be on for most cases.


#### Environment variables for SiteMind

Add the following lines to your .bashrc file. 

	alias sm-sync='/var/www/html/admin/bin/sync.sh'
	alias sm-user-list='cat /etc/apache2/.htpasswd | cut -d: -f1'
	alias sm-monitor='/var/www/html/admin/bin/monitor.sh'
	alias sm-user-new='/var/www/html/admin/bin/user-new.sh'
	alias sm-user-rm='/var/www/html/admin/bin/user-sh.sh'
	alias sm-commit='/var/www/html/admin/bin/commit.sh'
	alias sm-commit-version='cd ~/git/sitemind && /var/www/html/admin/bin/commit-version.sh'
	alias sm-commit-log='git log --oneline --decorate --color'
	alias sm-conf-nossl='vim /etc/apache2/sites-available/000-default.conf'
	alias sm-conf-ssl='vim /etc/apache2/sites-available/000-default-le-ssl.conf'
	alias sm-find-file='/var/www/html/admin/bin/sm-find-file.sh'

Learn more about the admin command line features here: 

https://github.com/SiteMindOpen/SiteMind/blob/master/admin/README.md


#### Running SiteMind locally on Mac OS X

If you're a mac user, go the public directory of the web server (/var/www/html) and exexcute the below command: 

    sudo php -S 127.0.0.1:80 && /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app="http://127.0.0.1/dev/index.html" --window-size="1000x800"

This same will obviously work on Linux and Windows, but the command will be something different. 
