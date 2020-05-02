
### Instalar docker
```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker ubuntu
```

### Instalar Postgres
```
sudo apt install postgresql -y
sudo su postgres
sed -i s/"#listen_addresses = 'localhost'"/"listen_addresses = '*'"/g /etc/postgresql/10/main/postgresql.conf
sed -i s/"local   all             postgres                                peer"/"local    all             postgres                                trust"/g /etc/postgresql/10/main/pg_hba.conf
sudo /etc/init.d/postgresql restart
sudo su - postgres -c "createuser -s odoo"
sudo -u postgres createdb odoo;
psql -U postgres -c "alter role odoo with password 'odoo';"
psql -U postgres -c "alter role postgres with password 'admin';"
sudo su postgres
sed -i s/"local    all             postgres                                trust"/"local   all             postgres                                md5 "/g /etc/postgresql/10/main/pg_hba.conf
sed -i s/"local   all             all                                     peer"/"local   all             odoo                                    md5"/g /etc/postgresql/10/main/pg_hba.conf
sudo /etc/init.d/postgresql restart
```


### Crear Dockerfile
```
mkdir Dockerimge && cd Dockerimage
vim Dockerfile
vim odoo.conf
```

### Crear Imagen
```
docker build -t odoo13 .
docker run --name odoo13-container -p 80:8069 odoo13 
```
