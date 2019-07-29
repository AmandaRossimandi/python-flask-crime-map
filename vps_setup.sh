!#/bin/bash

# Install MySQL
sudo apt-get install -y mysql-server

# Disable table access
sudo echo "skip-grant-tables" >> /etc/mysql/my.cnf

# Restart server
sudo /etc/init.d/mysql restart
sudo /etc/init.d/mysql stop
sudo /etc/init.d/mysql start

# Set new password
read -s -p "Enter Password: " password
mysqladmin --user=root password $password

# OR USE MySQL CONSOLE
# Start, remove privileges, set new password
# mysql -u root -p 
  # use at mysql> flush privileges;
  # ALTER USER 'root'@'localhost'  IDENTIFIED BY 'NewPassword';

# Remove disable table access
sudo sed '$d' /etc/mysql/my.cnf

# Open a prompt
echo "Open a prompt with 'mysql -p'"

# Python drivers for MySQL
pip install --user pymysql

# Clone
cd /var/www
git clone https://github.com/kayfay/python-flask-crime-map.git
cd python-flask-crime-map

# Add credentials
cat <<EOF > dbconfig.py
db_user = "root"
db_password = "NewPassword"
EOF

# Credit .gitignore
cat <<EOF > .gitignore
dbconfig.py
*.pyc
EOF

# Run database setup script
python db_setup.py

# More Stuff...

