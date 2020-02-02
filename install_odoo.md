sudo apt udpate
sudo apt dist-upgrade -y

sudo useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

sudo apt install postgresql -y
sudo su postgres
sed -i s/"#listen_addresses = 'localhost'"/"listen_addresses = '*'"/g /etc/postgresql/10/main/postgresql.conf
sed -i s/"local   all             postgres                                peer"/"local    all             postgres                                trust"/g /etc/postgresql/10/main/pg_hba.conf
ctrl + d
sudo /etc/init.d/postgresql restart