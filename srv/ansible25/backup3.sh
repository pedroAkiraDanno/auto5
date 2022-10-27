# Database name
db_name=test1

# Backup storage directory 
backupfolder=/postgresql/backups

# Notification email address 
recipient_email=username@mail.com

# Number of days to store the backup 
keep_day=30

sqlfile=$backupfolder/all-database-$(date +%d-%m-%Y_%H-%M).sql
zipfile=$backupfolder/all-database-$(date +%d-%m-%Y_%H-%M).zip

#create backup folder
mkdir -p $backupfolder

#install zip 
# sudo apt-get install zip -y
# sudo apt-get install unzip


# show file names 
echo $sqlfile
echo $zipfile


# Create a backup

if pg_dumpall > $sqlfile ; then
   echo 'Sql dump created'
else
   echo 'pg_dumpall return non-zero code' | mailx -s 'No backup was created!' $recipient_email
   exit
fi

# Compress backup 
if zip $zipfile $sqlfile ; then
   echo 'The backup was successfully compressed'
else
   echo 'Error compressing backup' | mailx -s 'Backup was not created!' $recipient_email
   exit
fi

rm $sqlfile 
echo $zipfile | mailx -s 'Backup was successfully created' $recipient_email

# Delete old backups 
find $backupfolder -mtime +$keep_day -delete






#TEST
# /var/lib/postgresql/scripts/backup.sh

# RESTORE
   # sudo su - postgres 
   # cd /postgresql/backups 
   # sudo less /var/mail/$(whoami)
   # mail
   # unzip -l file.zip 
   #
   # unzip file.zip  
   # cd postgresql/backups 
   # pgsql -f  file.sql postgres 
   # REFERENCE: https://www.tecmint.com/backup-and-restore-postgresql-database/

