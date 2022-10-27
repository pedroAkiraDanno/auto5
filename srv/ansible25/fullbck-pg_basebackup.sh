#Backup Dir
#Make sure this is a dedicated mount point to PostgreSQL Backups
#Don't put traling / in path
#Backup Details

backup_dir=/postgresql/pg_basebackup
export PGPASSWORD="postgres"
export PGPORT="5432"
echo -e "\n\nBackup Status: $(date +"%d-%m-%y-%T")" >> $backup_dir/Status.log
echo -e "-----------------------" >> $backup_dir/Status.log
echo -e "\nStart Time: $(date)\n" >> $backup_dir/Status.log
/usr/lib/postgresql/15/bin/pg_basebackup  -U postgres  -D $backup_dir/PostgreSQL_basebackup_$(date +"%d-%m-%y-%T") -l "'date'" -P -F tar -z -R &>> $backup_dir/Status.log
echo -e "\nEnd Time: $(date)" >> $backup_dir/Status.log

#Auto Deletion for Backups
#Value 7 for retention_duration will keep 8 days backups

retention_duration=7
find $backup_dir/PostgreSQL_basebackup* -type d -mtime +$retention_duration -exec rm -rv {} \;


#Auto Deletion for Status.log
#Value 30 for retention_duration will keep 31 days backups
#retention_duration=30
#find $backup_dir/*.log -type d -mtime +$retention_duration -exec rm -rv {} \;


#references:
# https://rayafeel.com/postgresmigration/backup-script-pg_basebackup/
# http://nervinformatica.com.br/blog/index.php/2017/05/23/postgresql-mini-manual-de-backup-e-recovery/