####################INSTALL ODOO#########################

$ sudo apt udpate
$ sudo apt dist-upgrade -y

$ sudo useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

$ sudo apt install postgresql -y
$ sudo su postgres
$ sed -i s/"#listen_addresses = 'localhost'"/"listen_addresses = '*'"/g /etc/postgresql/10/main/postgresql.conf
$ sed -i s/"local   all             postgres                                peer"/"local    all             postgres                                trust"/g /etc/postgresql/10/main/pg_hba.conf
ctrl + d
$ sudo /etc/init.d/postgresql restart

$ sudo su - postgres -c "createuser -s odoo"
$ sudo -u postgres createdb odoo;
$ psql -U postgres -c "alter role odoo with password 'odoo';"
$ psql -U postgres -c "alter role postgres with password 'admin';"
$ sudo su postgres
$ sed -i s/"local    all             postgres                                trust"/"local   all             postgres                                md5 "/g /etc/postgresql/10/main/pg_hba.conf
$ sed -i s/"local   all             all                                     peer"/"local   all             odoo                                    md5"/g /etc/postgresql/10/main/pg_hba.conf
ctrl + d
$ sudo /etc/init.d/postgresql restart

$ cd ~
$ sudo apt install wget git
$ wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
$ sudo apt install ./wkhtmltox_0.12.5-1.bionic_amd64.deb -y
$ sudo apt install python3-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev python3-pip -y
$ sudo rm wkhtmltox_0.12.5-1.bionic_amd64.deb
$ sudo apt update
$ sudo apt autoremove -y

$ sudo apt install -y npm
$ sudo npm install -g rtlcss

$ sudo su odoo
$ cd ~
$ pip3 install virtualenvwrapper
$ vim ~/.bashrc
```
++export WORKON_HOME=~/Envs
++export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.6
++source ~/.local/bin/virtualenvwrapper.sh
++export PATH=$PATH:~/.local/bin
´´´
$ source ~/.bashrc
$ mkvirtualenv odoo13
$ cdvirtualenv
$ git clone https://github.com/odoo/odoo.git
$ cd odoo
$ pip3 install -r requirements
$ pip3 install psycopg2-binary

$ echo '[options]' >> odoo-server.conf
$ echo 'db_host=localhost' >> odoo-server.conf
$ echo 'db_port=5432' >> odoo-server.conf
$ echo 'db_user=odoo' >> odoo-server.conf
$ echo 'db_password=odoo' >> odoo-server.conf
# echo 'logfile=/var/log/odoo13/odoo-server.log' >> odoo-server.conf
$ echo 'addons_path=/opt/odoo/Envs/odoo13/odoo/addons,/opt/odoo/Envs/odoo13/odoo/odoo/addons' >> odoo-server.conf

# python setup.py install
$ ./odoo-bin -c odoo-server.conf

###########################SUPERVISOR#####################
$ apt install supervisor -y
$ cd /etc/supervisor/conf.d/

$ echo '[program:odoo13]' >> spv_odoo13.conf
$ echo 'command=/opt/odoo/Envs/odoo13/bin/python3.6 /opt/odoo/Envs/odoo13/odoo/odoo-bin -c /opt/odoo/Envs/odoo13/odoo/odoo-server.conf' >> spv_odoo13.conf
$ echo 'autostart=true' >> spv_odoo13.conf
$ echo 'autorestart=true' >> spv_odoo13.conf
$ echo 'stdout_logfile=/var/log/odoo13/odoo-server.log' >> spv_odoo13.conf
$ echo 'stderr_logfile=/var/log/odoo13/odoo-server.log' >> spv_odoo13.conf
$ echo 'user=odoo' >> spv_odoo13.conf
$ echo 'stopsignal=KILL' >> spv_odoo13.conf

$ mkdir /var/log/odoo13
$ supervisorctl reload
$ supervisorctl status

##########################BACKUPS AUTOMATIC###############
$ psql -U odoo -h localhost -d demo

$ apt install awscli
$ aws configure
AWS Access Key ID [None]: ***
AWS Secret Access Key [None]: ***
Default region name [None]: us-east-1
Default output format [None]: json

####example aws commands########
# aws s3 mb s3://bucket-name
# aws s3 ls
# aws s3 ls s3://bucket-name
# aws s3 rb s3://bucket-name
# aws s3 rm s3://backut-name/file
# aws s3 rb s3://bucket-name --force
# aws s3 sync . s3://my-bucket/path --acl public-read

$ su odoo
$ cdvirtualenv
$ mkdir backups && cd backups
$ pg_dump -U odoo -W --no-owner -h localhost demo > demo.sql
$ cdvirtualenv
$ jobs && cd jobs
$ vim backups_edy.sh
```
#!/bin/bash
DATE=$(date +%d%m%Y-%H-%M)
DBNAME="${1:-$DEFAULTDBNAME}"
DUMPNAME=$DBNAME-$DATE.sql

cd /opt/odoo/Envs/odoo13/backups
PGPASSWORD='odoo' pg_dump -U odoo --no-owner -h localhost $DBNAME > $DUMPNAME
gzip -9 $DUMPNAME
aws s3 cp $DUMPNAME.gz s3://edy-backups --acl public-read
rm $DUMPNAME.gz
´´´
$ crontab -e 
```
# m h  dom mon dow   command
00 08 * * 1,2,3,4,5 /opt/odoo/Envs/odoo13/jobs/edy.sh
´´´
$ crontab -l
$ sudo service cron restart

########################DOMAIN HTTPS####################
$ sudo apt install nginx -y
$ cd /etc/nginx/sites-available
$ vim edy.conf
```
server {
        listen  80;
		server_name     www.edynsoncoronado.com edynsoncoronado.com;
        charset         utf-8;
        location / {
                proxy_pass          http://127.0.0.1:8069;
        }
}
´´´
$ nginx -t
$ ln -s /etc/nginx/sites-available/edy.conf /etc/nginx/sites-enabled/edy.conf
$ systemctl reload nginx.service

$ add-apt-repository ppa:certbot/certbot
$ apt update
$ apt install python-certbot-nginx -y
$ certbot --nginx -d edynsoncoronado.com -d www.edynsoncoronado.com