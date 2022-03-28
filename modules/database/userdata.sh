#!/bin/bash
sudo apt update -y
sudo apt install mysql-server -y
sudo mysql -u root <<MYSQL_SCRIPT
CREATE USER 'ttnprojects'@'%' IDENTIFIED BY 'ttnprojects';
GRANT PRIVILEGE ON *.* TO 'ttnprojects'@'%';
CREATE DATABASE projectDB;
MYSQL_SCRIPT

echo "Mysql is created"

