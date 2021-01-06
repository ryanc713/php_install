#!/bin/bash
#
# Author: Ryan Cook
# Date: 01/05/2021
# Description: Installs a different version of PHP for instance if a lower version is required to run an app.
php_version=$(php -r "echo PHP_VERSION;")

sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php && sudo apt update
clear

read -p "This script will install your choice of PHP versions and will 
also configure it to be the default PHP version running on your server."
echo ""
echo "What version of PHP do you want to install? The choices are:
    1. PHP5.6
    2. PHP7.0
    3. PHP7.1
    4. PHP7.2
    5. PHP7.3"
read opt1
case $opt1 in
    1)
        sudo apt install php5.6 php5.6-cli php5.6-xml php5.6-mysql -y
        sudo update-alternatives --set php /usr/bin/php5.6
        sudo a2dismod $php_version
        sudo a2enmod php5.6
        sudo systemctl restart apache2
        echo "Operation Completed. Check PHP version to verify"
        exit 0
        ;;
    2)
        sudo apt install php7.0 php7.0-cli php7.0-xml php7.0-mysql -y
        sudo update-alternatives --set php /usr/bin/php7.0
        sudo a2dismod $php_version
        sudo a2enmod php7.0
        sudo systemctl restart apache2
        echo "Operation Completed. Check PHP version to verify"
        exit 0
        ;;
    3)
        sudo apt install php7.1 php7.1-cli php7.1-xml php7.1-mysql -y
        sudo update-alternatives --set php /usr/bin/php7.1
        sudo a2dismod $php_version
        sudo a2enmod php7.1
        sudo systemctl restart apache2
        echo "Operation Completed. Check PHP version to verify"
        exit 0
        ;;
    4)
        sudo apt install php7.2 php7.2-cli php7.2-xml php7.2-mysql -y
        sudo update-alternatives --set php /usr/bin/php7.2
        sudo a2dismod $php_version
        sudo a2enmod php7.2
        sudo systemctl restart apache2
        echo "Operation Completed. Check PHP version to verify"
        exit 0
        ;;
    5)
        sudo apt install php7.3 php7.3-cli php7.3-xml php7.3-mysql -y
        sudo update-alternatives --set php /usr/bin/php7.3
        sudo a2dismod $php_version
        sudo a2enmod php7.3
        sudo systemctl restart apache2
        echo "Operation Completed. Check PHP version to verify"
        exit 0
        ;;
    *)
        echo "Not a valid Option."
        ;;
esac
