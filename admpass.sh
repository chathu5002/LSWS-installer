ADMIN_USER=admin
PASS_ONE=$(curl -s https://www.passwordrandom.com/query?command=password | cut -c 1-6)

echo $PASS_ONE > password.txt

ENCRYPT_PASS=`/usr/local/lsws/admin/fcgi-bin/admin_php -q /usr/local/lsws/admin/misc/htpasswd.php $PASS_ONE`
echo "$ADMIN_USER:$ENCRYPT_PASS" > /usr/local/lsws/admin/conf/htpasswd 
if [ $? -eq 0 ]; then
    echo "Administrator's username/password is updated successfully!"
fi