#!/bin/bash

if command -v wp &> /dev/null
then
    echo "WP-CLI is already installed."
else    
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    
    chmod +x wp-cli.phar
 
    mv wp-cli.phar /usr/local/bin/wp
fi
