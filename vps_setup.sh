!#/bin/bash

# Install MySQL
sudo apt-get install -y mysql-server

# Disable table access
sudo echo "skip-grant-tables" >> /etc/mysql/my.cnf

# Set new password
read -s -p "Enter Password: " password
mysqladmin --user=root password $password

# Remove disable table access
sudo sed '$d' /etc/mysql/my.cnf

# OR USE MySQL CONSOLE
# Start, remove privileges, set new password
# sudo /etc/init.d/mysql stop
# sudo /usr/sbin/mysqld --skip-grant-tables --skip-networking &
# mysql -u root
# FLUSH PRIVILEGES;
# update mysql.user set password=password('password") where user='root';
# FLUSH PRIVILEGES;
# exit

# Restart server
sudo /etc/init.d/mysql restart
sudo /etc/init.d/mysql stop
sudo /etc/init.d/mysql start

# Open a prompt
echo "Open a prompt with 'sudo mysql -u root -ppassword'"

# Install and configure Git, apache, pip
sudo apt-get install python-pip git apache2 libapache2-mod-wsgi
sudo chown -R $USER /var/www

# Python drivers for MySQL
pip install --user pymysql

# Clone Repo
cd /var/www
git clone https://github.com/kayfay/python-flask-crime-map.git
cd python-flask-crime-map

# Add credentials
cat <<EOF > dbconfig.py
db_user = "root"
db_password = "password"
EOF

# Credit .gitignore
cat <<EOF > .gitignore
dbconfig.py
*.pyc
EOF

# Run database setup script
python db_setup.py

# More Stuff...

