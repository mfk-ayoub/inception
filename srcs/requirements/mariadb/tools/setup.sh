#!/bin/bash


sudo service mariadb start
mysql -u root -p

mariadb -e  "CREATE DATABASE test"