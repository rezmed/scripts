#!/bin/bash

##################################
##	Remove oldest packages  ##
##	from  Pacman cache	##
##	for Arch users		##
##################################

init=$(ls /var/cache/pacman/pkg | wc -l )
lastfile=''
lastf=''
cp=0
dir="/var/cache/pacman/pkg/"
seddir=$( echo $dir | sed 's/\//\\\//g')
for f in $dir*;
do 
	file=$(echo "$f" | sed "s/$seddir//g" | grep '^[[:alnum:]-]*' -o  | sed 's/-[[:digit:]]+//g'  )
	if [[ $lastfile =  $file ]]
	then
		# if this is the same file  rm the precedent
		rm -f $lastf
		echo $lastf
		cp=$(( $cp + 1 ))
	else
		# else lastfile=file
		#[ ! $lastfile = '' ] && echo " $lastfile"
		lastfile=$file
	fi
	lastf=$f
done
echo "---- $cp package deleted ----" ;
