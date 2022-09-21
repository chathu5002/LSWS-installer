#!/bin/bash

install_LSWS () {
    wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | sudo bash
    sudo apt update
    sudo apt install openlitespeed -y
}

install_Apache () {
    sudo apt-get update
    sudo apt-get install apache2 apache2-utils -y

    # Enable Apache to start at system boot time
    sudo systemctl enable apache2
    sudo systemctl start apache2
    sudo systemctl status apache2
}

install_DBMS () {
    if [ "$varDBMS" = "1" ]; then
        install_MySQL
    elif [ "$varserver" = "2" ]; then
        install_MariaDB
    fi
}

install_MySQL () {
    sudo apt-get install mysql-client mysql-server -y
}

install_MariaDB () {
    sudo apt-get install mariadb-server mariadb-client -y
}

createDatabase () {
    db_date=`date +%s%N`;
    # db_suffix=${db_date:13:6};
    db_suffix=$(echo $db_date | cut -c13-18)
    db_name="wp_$db_suffix";
    echo $db_name > dbname.txt;

    user_date=`date +%s%N`;
    # user_suffix=${user_date:13:6};
    user_suffix=$(echo $user_date | cut -c13-18)
    user_name="user_$user_suffix";
    echo $user_name > dbusername.txt;

    db_password=$(curl -s https://www.passwordrandom.com/query?command=password | cut -c 1-6)
    echo $db_password > dbpassword.txt

    sudo mysql -e "CREATE DATABASE $db_name";
    sudo mysql -e "CREATE USER '$user_name'@'%' IDENTIFIED WITH mysql_native_password BY 'db_password'";
    sudo mysql -e "GRANT ALL ON $db_name.* TO '$user_name'@'%'";
    sudo mysql -e "FLUSH PRIVILEGES";
}

install_PHP_modules (){
    sudo apt-get install php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip
}

change_LSWS_password () {
    sudo sh admpass.sh
}

install_WordPress () {
    wget -c http://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    sudo mv wordpress/ /usr/local/lsws/Example/
}

echo
echo Initializing server configuration utility as user $(whoami) on $(uname)-$(uname -r)
echo
echo Press [1] to install webserver
echo Press [2] to install PHP
echo Press [3] to install DBMS
echo Press [4] to install WordPress
echo Press [5] to change LSWS password
echo
read -p 'Enter choice: ' varoption


if [ "$varoption" = "1" ]; then
    echo
    echo Press [1] to choose MySQL
    echo Press [2] to choose MariaDB
    echo
    read -p 'Enter choice: ' varDBMS
    echo
    echo Press [1] to install LSWS
    echo Press [2] to install Apache
    echo Press [3] to install Nginx
    echo
    read -p 'Enter choice: ' varserver
    echo
    # Install LSWS
    if [ "$varserver" = "1" ]; then
        echo "\e[1;31mInstalling Litespeed Webserver...\e[0m"
        echo
        install_LSWS
        change_LSWS_password
        echo "\e[1;31mInstalling DBMS...\e[0m"
        echo
        install_DBMS
        echo "\e[1;31mCreating Database...\e[0m"
        echo
        createDatabase
        echo "\e[1;31mInstalling WordPress...\e[0m"
        echo
        install_WordPress
        sudo rm latest.tar.gz
        echo "\e[1;31mServer configuration wizard finish.\e[0m"

    # Install Apache
    elif [ "$varserver" = "2" ]; then
        echo "\e[1;31mInstalling Apache Webserver...\e[0m"
        echo
        install_Apache
        echo "\e[1;31mInstalling PHP modules...\e[0m"
        echo
        install_PHP_modules
        echo "\e[1;31mInstalling DBMS...\e[0m"
        echo
        install_DBMS
        echo "\e[1;31mCreating Database...\e[0m"
        echo
        createDatabase
        echo "\e[1;31mInstalling WordPress...\e[0m"
        echo
        install_WordPress
        sudo rm latest.tar.gz
        echo "\e[1;31mServer configuration wizard finish.\e[0m"


    # Install Nginx
    elif [ "$varserver" = "3" ]; then
        echo "\e[1;31mInstalling Nginx Webserver...\e[0m"

    else
        echo "Invalid input"
    fi



elif [ "$varoption" = "2" ]; then
    install_PHP_modules
    echo "\e[1;31mInstalling DBMS...\e[0m"
    echo
elif [ "$varoption" = "3" ]; then
    echo "\e[1;31mInstalling DBMS...\e[0m"
    echo
    createDatabase
elif [ "$varoption" = "4" ]; then
    echo "\e[1;31mInstalling WordPress...\e[0m"
    echo
    install_WordPress
elif [ "$varoption" = "5" ]; then
    echo "\e[1;31mChanging LSWS password...\e[0m"
    sudo sh admpass.sh
else
    echo "Invalid input"
fi