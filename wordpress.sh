#!/bin/bash
echo "Installing apache"
yum install httpd
echo "Starting apache"
service httpd start
echo "browse to apache home directory"
cd /var/www/html
echo "Installing dependencies"
yum install php
yum install php-mysqlnd
echo "Installing MySQL server"
yum install yum install mysql56-server
echo "Setting up MySQL !!!!!!!!!!!!!!!!!!!! Please go through below steps with great care!"
service mysqld start
mysql_secure_installation
echo "creating database for Wordpress"
mysql -uroot -proot@123 -e"CREATE DATABASE Wordpress"
echo “Database Name: ”
read -e dbname
echo “Database User: ”
read -e dbuser
echo “Database Password: ”
read -s dbpass
echo “run install? '(y/n)'”
read -e run
if [ "$run" == n ] ; then
exit
else
#download wordpress
wget https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#change dir to wordpress
cd wordpress
#copy file to parent dir
cp -rf * ../
#move back to parent dir
cd ..
#remove files from wordpress folder
rm -R wordpress
#create wp config
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/$dbpass/g" wp-config.php
#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 777 wp-content/uploads
#remove zip file
rm latest.tar.gz
fi


