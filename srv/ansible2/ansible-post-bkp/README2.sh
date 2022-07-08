ansible-playbook -i hosts filesystem-playbook2.yml
ansible-playbook -i hosts db-server-playbook.yml
ansible-playbook -i  hosts backup_filesystem.yml
ansible-playbook -i hosts backupcron.yml
ansible-playbook -i hosts archive.yml
ansible-playbook -i hosts pgmetrics.yml
ansible-playbook -i hosts pgbackRest.yaml
ansible-playbook -i hosts swap.yml
ansible-playbook -i hosts pg_collector.yml
ansible-playbook -i hosts /etc/ansible/Load_sample_database_dvdrental.yml
/var/lib/postgresql/scripts/dvdrental.sh
ansible-playbook -i hosts /etc/ansible/db-temp.yml
ansible-playbook -i hosts /etc/ansible/large_sort_temporary_files.yml
ansible-playbook -i hosts /etc/ansible/pg_basebackup.yml
ansible-playbook -i hosts /etc/ansible/sudo.yml
ansible-playbook -i hosts /etc/ansible/pgbackRest-restore2.yaml
#ansible-playbook -i hosts pgAdmin.yaml
/var/lib/postgresql/scripts/pgbackrest-restore.sh

apt-get install -y postfix mailutils
/var/lib/postgresql/scripts/pgmetrics.sh

chown -R postgres /postgresql/backups/
chgrp -R postgres /postgresql/backups/
chmod +x /var/lib/postgresql/scripts/pg_collector_delete.sh
chmod +x /var/lib/postgresql/scripts/pgbadger_delete.sh

chmod +x /var/lib/postgresql/scripts/*.sh
chown -R postgres:postgres /postgresql/
#sudo passwd postgres
