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
# UPDATE mysql.user SET plugin='mysql_native_password' WHERE user ='root';
# UPDATE mysql.user SET password=password('password') WHERE user='root';
# FLUSH PRIVILEGES;
# exit
# sudo kill `pgrep mysql`

# Restart server
sudo /etc/init.d/mysql restart
sudo /etc/init.d/mysql stop
sudo /etc/init.d/mysql start

# Install and configure Git, apache, pip
sudo apt-get install python-pip git apache2 libapache2-mod-wsgi
sudo chown -R $USER /var/www

# Python drivers for MySQLA, flask
pip install --user -r dependencies.txt

# Clone Repo
cd /var/www
git clone https://github.com/kayfay/python-flask-crime-map.git
cd python-flask-crime-map

# Add credentials and a test flag for the VPS
# and test = True for local testing
cat <<EOF > dbconfig.py
test = False
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

# Open a prompt and issue test commands
echo "Open a prompt with 'mysql -u root -ppassword'"
echo "---------------------------------------------"
echo "set database with 'USE crimemap;'"
echo "view tables 'SHOW TABLES FROM crimemap;'"
echo "view description 'DESCRIBE crimes;'"
echo "insert data with 'INSERT into crimes (description) VALUES ('arbitraryData');'"
echo "read data with 'SELECT description FROM crimes;'"
echo "delete data with 'DELETE FROM crimes';"

# Pull fresh from repo
git pull origin master

# Create .wsgi file
cat <<EOF > crimemap.wsgi
import sys
sys.path.insert(0, "/var/www/crimemap")
from crimemap import app as application
EOF

# Create Apache Configuration file
cd /etc/apache2/sites-available
cat <<EOF > crimemap.conf
<VirtualHost *>
	ServerName example.com

	WSGIScriptAlias / /var/www/python-flask-crime-map/crimemap.wsgi
	WSGIDaemonProcess crimemap user=user
	<Directory /var/www/crimemap>
		WSGIProcessGroup crimemap
		WSGIApplicationGroup %{GLOBAL}
			Order deny,allow
			Allow from all
	</Directory>
</VirtualHost>
EOF

# Create a CSS directory and css style file
mkdir -p static/css
touch static/css/style.css

# Deactivate old conf and Activate new conf
# sudo a2dissite headlines.conf # skip if using new environment
sudo a2dissite 000-default.conf # if using new environment
sudo a2ensite crimemap.conf
sudo systemctl reload apache2

# monitor for error messages
sudo tail -f /var/log/apache2/error.log
