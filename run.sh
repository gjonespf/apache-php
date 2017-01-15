#!/bin/bash

chmod -R a+rx /scripts/*.sh && chmod -R a+rx /scripts/init.d/*.sh

#Inits
for SCRIPT in /scripts/init.d/*.sh; 
do
    if [ -f $SCRIPT -a -x $SCRIPT ]
    then
        echo "Executing startup script $SCRIPT"
        sync; sleep 1;
        $SCRIPT
    fi
done

source /etc/apache2/envvars
touch /scripts/.apacheenv
source /scripts/.apacheenv
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
