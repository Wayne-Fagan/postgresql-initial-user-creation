#!/bin/bash

# Create initial postgres user, escalate privileges for user, create local-development database.


echo '***********************************'
echo 'Creating user account with password'
echo '***********************************'

sudo su - postgres -c "psql -c \"CREATE USER wgf WITH PASSWORD 'wgf'\""
sudo su - postgres -c "psql -c \"\du\""

echo '***********************************'
echo 'Update user privileges'
echo '***********************************'

sudo su - postgres -c "psql -c \"ALTER USER wgf CREATEDB SUPERUSER REPLICATION CREATEROLE\""

echo '***********************************'
echo 'Restart postgres server'
echo '***********************************'
sudo systemctl restart postgresql
sudo systemctl status postgresql --no-pager

echo '*************************************************************************'
echo 'Create local development database, grant privileges to newly created user'
echo '*************************************************************************'

sudo su - postgres -c "psql -c \"CREATE DATABASE local_development\""
sudo su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE local_development TO wgf\""
sudo su - postgres -c "psql -P pager=off -c \"\l\""

echo '*************************************************************************'
echo 'Initial user account created, privileges escalated for user,'
echo 'local development database created, user assigned to to database'
echo '*************************************************************************'