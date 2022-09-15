CREATE DATABASE database_name;
CREATE USER 'username'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
GRANT ALL ON database_name.* TO 'username'@'%';
FLUSH PRIVILEGES;
EXIT;