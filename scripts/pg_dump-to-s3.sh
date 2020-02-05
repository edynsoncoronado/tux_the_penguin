#!/bin/bash
#Creates a pgdump and uploads it to a s3 bucket
# install with pip install awscli , apt install is not sure because dont create aws in /usr/local/bin/
#usage: 
#    pgdump-to-s3.sh [database_name] [bucket_folder] [bucket_name]

DEFAULTBUCKETNAME=backupsrepos
DEFAULTBUCKETFOLDER=test
DEFAULTDBNAME=dockert
DEFAULTDUMPLOCATION=/tmp

DBNAME="${1:-$DEFAULTDBNAME}"
BUCKETFOLDER="${2:-$DEFAULTBUCKETFOLDER}"
BUCKETNAME="${3:-$DEFAULTBUCKETNAME}"
DUMPLOCATION=$DEFAULTDUMPLOCATION

BDPASSWORD='****'

DATE=$(date +%d%m%Y-%H-%M)
DUMPNAME=$DBNAME-$DATE.sql
DUMPPATH=$DUMPLOCATION/$DUMPNAME
GZPATH=$DUMPPATH.gz
#added .gz at end to reflect that this is a gzipped file
BUCKETURL=s3://$BUCKETNAME/$BUCKETFOLDER/$DUMPNAME.gz

#Create postgres DB backup
PGPASSWORD=$BDPASSWORD pg_dump -U postgres --no-owner -h x.x.x.x $DBNAME > $DUMPNAME
sudo chown ubuntu:ubuntu $DUMPPATH
echo "#############################################"
echo "1. Backup $DBNAME sqldump for $DBNAME created"
#Gzip file creates file with name $GZPATH
gzip $DUMPPATH
echo "2. Backup $DBNAME compressed with gzip"

#Send backup to s3 bucket (aws previously configured)
/usr/local/bin/aws s3 cp $GZPATH $BUCKETURL --acl public-read
echo "3. Backup $DBNAME sqldump uploaded: $GZPATH to s3 bucket"

#Delete created backup
rm -f $GZPATH
echo "4.Backup $DBNAME sqldump local file deleted "
echo "############################################"