#!/bin/bash

sudo apt-get install mysql-server-5.7 mysql-client-5.7
systemctl status mysql.service
systemctl start mysql.service
sudo /usr/bin/mysql_secure_installation


#sudo apt-get install tomcat8 (doesnt work for some daam reason)
sudo cp /oreka-src/orktrack/target/orktrack-0.0.1-SNAPSHOT.war /var/lib/tomcat8/webapps/orktrack.war

sudo groupadd tomcat
sudo useradd -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
 
