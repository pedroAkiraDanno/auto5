# db_version
db_version=14


# 1. Set bin
#echo "PATH=/usr/lib/postgresql/$db_version/bin" >> ~/.bash_profile

#2. Set Data directory in PostgreSQL
 echo "PGDATA=/var/lib/postgresql/$db_version/main" >> ~/.bash_profile


#3. Set postgres database.
 echo "PGDATABASE=postgres" >> ~/.bash_profile

#4. Set postgres user.
 echo "PGUSER=postgres" >> ~/.bash_profile

#5. Set postgres port.
 echo "PGPORT=5432" >> ~/.bash_profile


# PostgreSQL aliases
#alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
#alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"


#Finally run the source command.
source ~/.bash_profile
. ~/.bash_profile 




#exec
# vi Environmental_Variables.sh
# chmod +x Environmental_Variables.sh
# ./Environmental_Variables.sh


