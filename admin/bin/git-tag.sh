#!/bin/bash

CURRENT=$(git log --oneline --decorate --color | head -1 | cut -d ')' -f2 | cut -d ' ' -f2)
VERSION3=$(echo $CURRENT | rev | cut -d. -f1);
VERSION2=$(echo $CURRENT | rev | cut -d. -f2);
VERSION1=$(echo $CURRENT | rev | cut -d. -f3);

if [ $VERSION3 -ge 9 ]; then
	OUTPUT3=0
	OUTPUT2=$(expr $VERSION2 + 1)
	if [ $VERSION2 -ge 9 ]; then
		OUTPUT2=0
		OUTPUT1=$(expr $VERSION1 + 1)
	else
		OUTPUT2=$(expr $VERSION2 + 1)
		OUTPUT1=$VERSION1
	fi
else
	OUTPUT3=$(expr $VERSION3 + 1)
	OUTPUT2=$VERSION2
	OUTPUT1=$VERSION1
fi

TAG=$(echo -e "$OUTPUT1.$OUTPUT2.$OUTPUT3")

echo $TAG
