#!/bin/bash
# Ask the user for login details
echo Press [1] to install PHP
echo Press [2] to install LSWS
echo Press [3] to configure LSWS
echo
read -p 'Enter choice: ' varoption

echo

if [ "$varoption" = "1" ]; then
    echo ">>>>>>> Installing Litespeed Webserver <<<<<<<"
    wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | sudo bash
    # 2>&1 file.txt would read as stderr goes to stdout (terminal), stdout goes to file, so you will see error output but normal output would go to the file.
    sudo apt update 1> apt-update.log
    sudo apt install openlitespeed 1> lsws-install.log
elif [ "$varoption" = "2" ]; then
    echo "Installing LSWS"
elif [ "$varoption" = "3" ]; then
    echo "Configuring LSWS"
fi
