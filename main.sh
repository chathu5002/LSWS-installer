#!/bin/bash
# Ask the user for login details
echo Press [1] to install PHP
echo Press [2] to install LSWS
echo Press [3] to configure LSWS
echo
read -p 'Enter choice: ' varoption

echo

if [ "$varoption" = "1" ]; then
    echo ">>>>>>> Installing PHP <<<<<<<"
    wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | sudo bash
    sudo apt update
    sudo apt install openlitespeed
elif [ "$varoption" = "2" ]; then
    echo "Installing LSWS"
elif [ "$varoption" = "3" ]; then
    echo "Configuring LSWS"
fi
