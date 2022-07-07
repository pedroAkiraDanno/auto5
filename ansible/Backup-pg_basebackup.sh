#!/bin/bash
export NOW=`date +%Y%m%d-%T`
mkdir /postgresql/pg_basebackup/$NOW
pg_basebackup --format=tar --gzip --compress=9 --progress --pgdata /postgresql/pg_basebackup/$NOW



#references:
# https://rayafeel.com/postgresmigration/backup-script-pg_basebackup/
# http://nervinformatica.com.br/blog/index.php/2017/05/23/postgresql-mini-manual-de-backup-e-recovery/