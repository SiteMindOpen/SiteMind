#!/bin/bash

GITDIR=~/git/sitemind/
DATE=`date +%d%m%y`
BACKUP=~/backup/commit_"$DATE"/
VERSION=$(sm-commit-version)

CHECK0=$(pwd)
CHECK1=$(ls ~/backup/commit_"$DATE")
CHECK2=$(git tag | grep fatal | tr -d ' ')
HOME=~/git/sitemind

	if [ -z $CHECK1]; then
		mkdir ~/backup/commit_"$DATE"/
	fi

	if [ -n $CHECK2]; then
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

	git tag -a v"$VERSION" -m "version "$VERSION""
	git add *
	git commit -m "$VERSION commit on "$DATE""

	eval `ssh-agent -s` && ssh-add ~/.ssh/git
	git push origin master
	git push origin master --tags
