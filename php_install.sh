#!/bin/bash
#
# Author: Ryan Cook
# Date: 01/05/2021
# Description: Installs Latest Release or Older Releases of PHP depending on user input.

header() {
    clear
    echo "***********************************"
    echo "*          PHP Installer          *"
    echo "***********************************"
    echo ""         
}
latest() {
# Install Software-properties-common file and install the ppa:ondrej repository
    apt install software-properties-common -y &>/dev/null
    header
    echo "Installing PHP Repository.."
    add-apt-repository ppa:ondrej/php -y &>/dev/null && apt update &>/dev/null
    echo "Complete."
# Install Latest version of PHP

    if [[ "$apache_ws" == yes ]]; then
        apt install libapache2-mod-php -y &>/dev/null
    fi
    if [[ "$mysql_db" == yes ]]; then
        apt install php"$version"-mysql -y &>/dev/null
    fi
    apt install php"$version" php"$version"-fpm -y &>/dev/null
    echo "Installation Complete.."
    update-alternatives --set php /usr/bin/php"$version" &>/dev/null
    sleep 2
}
prompt() {
    header
    echo "Which version of PHP do you want to install?"
    echo ""
    echo "WARNING - This script changes the default version of PHP currently being run"
    echo "on your server. If you have an app that requiures a specific version of PHP,"
    echo "it will not work after this script is done."
    echo ""
    echo "Do you want to continue with the installation?" 
    read continue
    case $continue in
        Y|y|yes|Yes)
            header
            echo "What version of PHP do you want to install? [1-7]:
            1. 5.6
            2. 7.0
            3. 7.1
            4. 7.2
            5. 7.3
            6. 7.4
            7. 8.0"
            read option
                case $option in
                    1) version=5.6
                        ;;
                    2) version=7.0
                        ;;
                    3) version=7.1
                        ;;
                    4) version=7.2
                        ;;
                    5) version=7.3
                        ;;
                    6) version=7.4
                        ;;
                    7) version=8.0
                        ;;
                    *) header
                        echo "$option is not a valid choice.."
                        echo "Exiting.."
                        sleep 2
                        exit 1
                esac
            check_apps
            php_install    
            ;;
        N|n|no|No)
            echo "Exiting Script.."
            sleep 2
            exit 0
            ;;
        *)
            echo "$continue was not a valid option. Exiting.."
            sleep 2
            exit 3
            ;;
    esac
}
if [[ $EUID -ne 0 ]]; then
    header
    echo "Script must be ran with root privileges.."
    sleep 2
    exit 1
else
    header
    echo "Checking for PHP installation.."
    command -v php &>/dev/null
    if [[ $? -ne 0 ]]; then
        header
        echo "No version of PHP has been detected.."
        echo "Do you want to install the latest version?"
        read opt
        case $opt in
            y|Y|yes|Yes)
                latest
                ;;
            N|n|no|No)
                prompt
                ;;
            *)
                echo "$opt was not a valid choice.."
                echo "Exiting.."
                sleep 2
                exit 1
                ;;
        esac
    fi
fi
