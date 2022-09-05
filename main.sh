#!/bin/bash
echo
echo Initializing server configuration utility as user $(whoami) on $(uname)-$(uname -r)
echo
echo Press [1] to install webserver
echo Press [2] to install PHP
echo Press [3] to install DBMS
echo Press [4] to install WordPress
echo
read -p 'Enter choice: ' varoption
echo

if [ "$varoption" = "1" ]; then
    echo
    echo Press [1] to install Litespeed server
    echo Press [2] to install Apache
    echo Press [3] to install Nginx
    echo
    read -p 'Enter choice: ' varserver
    # echo
    if [ "$varoption" = "1" ]; then
        echo ">>>>>>> Installing Litespeed Webserver <<<<<<<"
    elif [ "$varoption" = "2" ]; then
        echo ">>>>>>> Installing Apache Webserver <<<<<<<"
    elif [ "$varoption" = "3" ]; then
        echo ">>>>>>> Installing Nginx Webserver <<<<<<<"
    else
        echo "Invalid input"
    fi



    # echo ">>>>>>> Installing Litespeed Webserver <<<<<<<"
    # wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | sudo bash
    # # 2>&1 file.txt would read as stderr goes to stdout (terminal), stdout goes to file, so you will see error output but normal output would go to the file.
    # sudo apt update 2>&1 | tee apt-update.log
    # sudo apt install openlitespeed 2>&1 | tee lsws-install.log

elif [ "$varoption" = "2" ]; then
    echo "Installing PHP"
elif [ "$varoption" = "3" ]; then
    echo "Installing DBMS"
elif [ "$varoption" = "4" ]; then
    echo "Installing WordPress"
else
    echo "Invalid input"
fi
