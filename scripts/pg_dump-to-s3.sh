#!/bin/bash
DEFAULTBUCKETNAME=backupsyaros
DEFAULTBUCKETFOLDER=test
DEFAULTDBNAME=dockert
DEFAULTDUMPLOCATION=/tmp

DBNAME=$(python3 -c "import base64; b = base64.b64decode(b'${1:-$DEFAULTDBNAME}').decode('utf-8'); print(b)")
BUCKETNAME=$(python3 -c "import base64; b = base64.b64decode(b'${2:-$DEFAULTBUCKETNAME}').decode('utf-8'); print(b)")
BUCKETFOLDER=$(python3 -c "import base64; b = base64.b64decode(b'${3:-$DEFAULTBUCKETFOLDER}').decode('utf-8'); print(b)")
DUMPLOCATION=$DEFAULTDUMPLOCATION
DBUSER=$(python3 -c "import base64; b = base64.b64decode(b'$4').decode('utf-8'); print(b)")
DBPASSWORD=$(python3 -c "import base64; b = base64.b64decode(b'$5').decode('utf-8'); print(b)")
SERVERIP=$(python3 -c "import base64; b = base64.b64decode(b'$6').decode('utf-8'); print(b)")

echo "DBNAME: $DBNAME"
echo "BUCKETNAME: $BUCKETNAME"
echo "BUCKETFOLDER: $BUCKETFOLDER"
echo "DUMPLOCATION: $DUMPLOCATION"
echo "DBUSER: $DBUSER"
echo "DBPASSWORD: $DBPASSWORD"

DATE=$(date +%d%m%Y-%H-%M)
DUMPNAME=$DBNAME-$DATE.sql
DUMPPATH=$DUMPLOCATION/$DUMPNAME
GZPATH=$DUMPPATH.gz
BUCKETURL=s3://$BUCKETNAME/$BUCKETFOLDER/$DUMPNAME.gz
echo "DATA: $DATE"
echo "DUMPNAME: $DUMPNAME"
echo "DUMPAHT: $DUMPPATH"
echo "GZPATH: $GZPATH"
echo "BUCKETURL: $BUCKETURL"
echo "#############################################"

PGPASSWORD=$DBPASSWORD pg_dump -U $DBUSER --no-owner -h $SERVERIP $DBNAME > $DUMPPATH
sudo chown ubuntu:ubuntu $DUMPPATH
echo "1. Backup $DBNAME sqldump for $DBNAME created in $DUMPPATH"

gzip -9 $DUMPPATH
echo "2. Backup $DBNAME compressed with gzip"

/usr/local/bin/aws s3 cp $GZPATH $BUCKETURL --acl public-read
echo "3. Backup $DBNAME sqldump uploaded: $GZPATH to s3 bucket"

rm -f $GZPATH
echo "4.Backup $DBNAME sqldump local file deleted"
echo "############################################"