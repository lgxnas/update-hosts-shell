#!/bin/bash

CPIP=$(nmblookup win-01702201552|cut -d' ' -f1)
SETIP=$(cat /etc/hosts|grep win-01702201552|cut -d' ' -f1)
#echo $CPIP $SETIP
if [ "$CPIP" != "$SETIP" ];then
#	echo "no"
	sed -i "s/${SETIP}/${CPIP}/g" /etc/hosts
fi
#tail -n1 /etc/hosts 
