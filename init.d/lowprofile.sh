#!/bin/bash
#Minimise the memory consumption of Apache by default, so it can run multiple (docker) instances happily
cat <<EOT >> /etc/apache2/sites-available/000-default.conf
<IfModule mpm_prefork_module>
        StartServers            1
        MinSpareServers         1
        MaxSpareServers         2
        MaxRequestWorkers       30
        MaxConnectionsPerChild  0
</IfModule>
<IfModule mpm_worker_module>
    StartServers          1
    MinSpareThreads       5
    MaxSpareThreads      15 
    ThreadLimit          25
    ThreadsPerChild       5
    MaxClients           25
    MaxRequestsPerChild 200
</IfModule>
EOT

#TODO: Event should be lower profile?
# a2dismod mpm_prefork
# a2enmod mpm_worker
# apachectl -V | grep -i mpm

