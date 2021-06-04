#!/bin/bash
#
# Author: Ryan Cook
# Date: 01/05/2021
# Description: Installs a different version of PHP for instance if a lower version is required to run an app.
php_version=$(php -r "echo PHP_VERSION;")

header() {
    clear
    echo "***********************************"
    echo "*          PHP Installer          *"
    echo "***********************************"
    echo ""         
}
latest() {
    apt install software-properties-common -y &>/dev/null
    header
    echo "Installing PHP Repository.."
    add-apt-repository ppa:ondrej/php -y &>/dev/null && apt update &>/dev/null
    echo "Complete."
    echo "Installing Latest version of PHP.."
    apt install php php-mysql php-cli php-fpm -y &>/dev/null
    echo "Installation Complete"
    sleep 2
    exit 0
}
prompt() {
    header
    echo "Which version of PHP do you want to install?"
    echo ""
    echo "WARNING - If you have PHP already installed, after this script"
    echo "it will no longer be the default version running on this server."
    echo ""
    echo "What version of PHP do you want to install? Choose [1-7]
    1. PHP5.6
    2. PHP7.0
    3. PHP7.1
    4. PHP7.2
    5. PHP7.3
    6. PHP7.4
    7. PHP8.0"
    read opt1
}

php -v &>/dev/null
    if [[ $? -ne 0 ]]; then
        header
        echo "PHP is not currently installed on this system. Do you want"
        echo "to install the latest version of php?"
        read opt2
        case $opt2 in
            Y|yes|Yes|y)
                latest
                ;;
            N|no|No|n)
                prompt
                ;;
            *)
                echo "$opt2 was not a valid choice."
                exit 1
                ;;
        esac    
    else
        header
        echo "Adding PHP Repository.."
        apt install software-properties-common -y &>/dev/null
        add-apt-repository ppa:ondrej/php -y &>/dev/null 
        header
        echo "Updating System.."
        apt update &>/dev/null
        echo "Done"

prompt

case $opt1 in
    1)
        header
        echo "Installing PHP and basic Modules.."
        sudo apt install php5.6 php5.6-cli php5.6-xml php5.6-mysql -y &>/dev/null
        echo "Set as the default version.."
        sudo update-alternatives --set php /usr/bin/php5.6 &>/dev/null
        echo "Done."
        sleep 2
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
    6)
        sudo apt install php7.4 php7.4-cli php7.4-common php7.4-mysql php7.4-opcache php7.4-zip php7.4-fpm  -y
        sudo update-alternatives --set php /usr/bin/php7.4
        sudo a2dismod $php_version
        sudo a2enmod php7.4
        sudo systemctl restart apache2
        echo "Operation Completed. Check PHP version to verify"
        exit 0
        ;;
     7)
        sudo apt install php8.0 php8.0-common php8.0-cli php8.0-mysql -y
        sudo update-alternatives --set php /usr/bin/php8.0
        sudo a2dismod $php_version
        sudo a2enmod php8.0
        sudo systemctl restart apache2
        echo "Operation Completed. Check PHP version to verify"
        exit 0
        ;;
    *)
        echo "Not a valid Option."
        ;;
esac
