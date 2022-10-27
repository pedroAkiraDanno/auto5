# Backup storage directory 
pg_collectorfolder=/postgresql/pg_collector/

# Number of days to store the backup 
keep_day=30

#sqlfile=$pg_collectorfolder/pg_collector_*
#zipfile=$pg_collectorfolder/pg_collector_$(date +%d-%m-%Y_%H-%M-%S).zip


# Compress backup 
#if gzip -c $sqlfile > $zipfile; then
#   echo 'The backup was successfully compressed'
#else
#   echo 'Error compressing backup' | mailx -s 'Backup was not created!' $recipient_email
#   exit
#fi

#rm $sqlfile 
#echo $zipfile | mailx -s 'Backup was successfully created' $recipient_email

# Delete old backups 
find $pg_collectorfolder -mtime +$keep_day -delete


