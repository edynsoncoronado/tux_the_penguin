#!/bin/bash

DEFAULTBUCKETNAME=backupsrepos
DEFAULTBUCKETFOLDER=test
DEFAULTDBNAME=dockert
DEFAULTDUMPLOCATION=/tmp

DBNAME="${1:-$DEFAULTDBNAME}"
BUCKETNAME="${2:-$DEFAULTBUCKETNAME}"
BUCKETFOLDER="${3:-$DEFAULTBUCKETFOLDER}"
DUMPLOCATION=$DEFAULTDUMPLOCATION
echo "DBNAME: $DBNAME"
echo "BUCKETNAME: $BUCKETNAME"
echo "BUCKETFOLDER: $BUCKETFOLDER"
echo "DUMPLOCATION: $DUMPLOCATION"
BDPASSWORD='****'
DBUSER='postgres'

DATE=$(date +%d%m%Y-%H-%M)
DUMPNAME=$DBNAME-$DATE.sql
DUMPPATH=$DUMPLOCATION/$DUMPNAME
GZPATH=$DUMPPATH.gz
#added .gz at end to reflect that this is a gzipped file
BUCKETURL=s3://$BUCKETNAME/$BUCKETFOLDER/$DUMPNAME.gz
echo "DATA: $DATE"
echo "DUMPNAME: $DUMPNAME"
echo "DUMPAHT: $DUMPPATH"
echo "GZPATH: $GZPATH"
echo "BUCKETURL: $BUCKETURL"
echo "#############################################"
PGPASSWORD=$DBPASSWORD pg_dump -U $DBUSER --no-owner -h x.x.x.x $DBNAME > $DUMPPATH
sudo chown ubuntu:ubuntu $DUMPPATH
echo "1. Backup $DBNAME sqldump for $DBNAME created in $DUMPPATH"
#Gzip file creates file with name $GZPATH
gzip -9 $DUMPPATH
echo "2. Backup $DBNAME compressed with gzip"

/usr/local/bin/aws s3 cp $GZPATH $BUCKETURL --acl public-read
echo "3. Backup $DBNAME sqldump uploaded: $GZPATH to s3 bucket"

rm -f $GZPATH
echo "4.Backup $DBNAME sqldump local file deleted"
echo "############################################"