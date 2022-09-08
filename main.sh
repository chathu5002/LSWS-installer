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


if [ "$varoption" = "1" ]; then
    echo
    echo Press [1] to install LSWS
    echo Press [2] to install Apache
    echo Press [3] to install Nginx
    echo
    read -p 'Enter choice: ' varserver
    echo
    if [ "$varserver" = "1" ]; then
        
        echo -e "\e[1;31mInstalling Litespeed Webserver...\e[0m"
        echo
        wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | sudo bash
        # 2>&1 file.txt would read as stderr goes to stdout (terminal), stdout goes to file, so you will see error output but normal output would go to the file.
        # sudo apt update 2>&1 | tee apt-update.log
        # sudo apt install openlitespeed 2>&1 | tee lsws-install.log
        sudo apt update
        sudo apt install openlitespeed


        ADMIN_USER=admin
        PASS_ONE=$(curl -s https://www.passwordrandom.com/query?command=password)
        echo "$PASS_ONE" > password.txt

        ENCRYPT_PASS=`/usr/local/lsws/admin/fcgi-bin/admin_php -q /usr/local/lsws/admin/misc/htpasswd.php $PASS_ONE`
        sudo echo "$ADMIN_USER:$ENCRYPT_PASS" > `sudo /usr/local/lsws/admin/conf/htpasswd`
        if [ $? -eq 0 ]; then
            echo "Administrator's username/password is updated successfully!"
        fi


    elif [ "$varserver" = "2" ]; then
        echo -e "\e[1;31mInstalling Apache Webserver...\e[0m"
    elif [ "$varserver" = "3" ]; then
        echo -e "\e[1;31mInstalling Nginx Webserver...\e[0m"
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
