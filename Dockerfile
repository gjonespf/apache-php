#TODO: Base on great work FROM
#https://hub.docker.com/r/eboraas/apache/
FROM ubuntu:trusty
#MAINTAINER Fernando Mayo <fernando@tutum.co>
MAINTAINER Gavin Jones <gjones@powerfarming.co.nz>

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl \
        nano \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-mcrypt \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  
RUN /usr/sbin/php5enmod mcrypt
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

ENV ALLOW_OVERRIDE **False**
ENV TERM xterm

# Add image configuration and scripts
RUN     mkdir -p /scripts/init.d/
COPY    run.sh /scripts/run.sh
COPY    init.d/ /scripts/init.d/
RUN     chmod -R a+rx /scripts/*.sh && chmod -R a+rx /scripts/init.d/*.sh 

# Configure /app folder with sample app
RUN mkdir -p /app/sample && rm -fr /var/www/html && ln -s /app /var/www/html
COPY sample/ /app/sample

#Overwrite default config
COPY sites-available/ /etc/apache2/sites-available/

EXPOSE 80
WORKDIR /app
CMD ["/scripts/run.sh"]
