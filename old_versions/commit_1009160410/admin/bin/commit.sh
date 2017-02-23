#!/bin/bash

GITDIR=/root/git/sitemind/
DATE=`date +%d%m%y%H%M`
BACKUP=~/backup/commit_"$DATE"
VERSION=$(/var/www/html/admin/bin/commit-version.sh)

CHECK2=$(git tag | grep fatal | tr -d ' ')
HOME=~/git/sitemind

	if [ -n $CHECK2 ]; then
		git init
	fi

	rsync -av /var/www/html/dev $BACKUP
	rsync -av /var/www/html/admin $BACKUP
	rsync -av /var/www/html/sitemind/bin $BACKUP/sitemind
	rsync -av /var/www/html/sitemind/s33r.sh $BACKUP/sitemind
	rsync -av /var/www/html/sitemind/hello.sh $BACKUP/sitemind
	rsync -av /var/www/html/README.md $BACKUP
	
	rsync -av --exclude=.git $BACKUP $GITDIR --delete

	cd $HOME

	git tag -a $VERSION -m 'version $VERSION'
	git add *
	#	git commit -m $VERSION "commit on "$DATE""

	git push origin master
	git push origin master --tags
