## ADMIN FEATURES 

In the environment of the host machine, include the following alias commands: 

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

Usually you can find the file from ~/ under the name .bashrc. Add the above lines in to the file and next time you login to the host, the following commands will be available anywhere in your system: 

##### sm-sync

Syncs all the user accounts with /dev.

##### sm-user-list

Prints out a list of user accounts. 

##### sm-monitor

Creates a report out of access and error logs from the on going day's logs. 

##### sm-user-new

Creates a new user in to the system and prints out a randomly generated password for the user. 

EXAMPLE USAGE (where we want to create a user 'john':

    sm-newuser john

##### sm-user-rm

Removes a user and all associated files from the system (Use with caution!).

#### sm-commit

Creates a commit package ready for download / other use. You should also add this to your crontab:

    crontab -e

and then add line: 

    59 23 * * * /var/www/html/admin/bin/commit.sh

Once this is done, you can decide what to do with it, for example get it to a local machine: 

    date +%d%m%y`; rsync -av root@199.193.6.104:~/backup/commit_"$DATE"/ ~/GitHub/SiteMind --delete

#### sm-commit-version 

Displays the current dev version (the version to be pushed next). 

#### sm-commit-log

Displays the log of all commits so far. 

#### sm-conf-nossl

Opens up the no ssl (port 80) apache configuration file in vim editor. 

#### sm-conf-ssl

Opens up the ssl (port 443) apache configuration file in vim editor. 
