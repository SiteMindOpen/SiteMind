FILE=$1
	locate $FILE | while read VAR1; 
		do 
			wc -l $VAR1; 
		done;
