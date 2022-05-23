#!/bin/bash
info "Install additional software"
apt-get install -y php7.1-curl ...
info "Install PostgreSQL"
apt-get install -y postgresql-9.5 postgresql-client-9.5 postgresql-contrib-9.5
info "Configure PostgreSQL"
sudo -u postgres psql -c "CREATE USER root WITH PASSWORD 'root'"
service postgresql restart
echo "Done!"
info "Initailize databases for PostgreSQL"
sudo -u postgres psql -c "CREATE DATABASE yii2advanced"
sudo -u postgres psql -c "CREATE DATABASE yii2advanced_test"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE yii2advanced TO root"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE yii2advanced_test TO root"
echo "Done!"