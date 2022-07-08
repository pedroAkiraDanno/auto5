# OS User: postgres
# Application: PostgreSQL Software Owner
# Version: PostgreSQL 14.3 (Ubuntu 14.3-1.pgdg22.04+1) on aarch64-unknown-linux-gnu, compiled by gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0, 64-bit
# ---------------------------------------------------
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

#umask 022# .bash_profile

# db_version
db_version=14

#2. Set Data directory in PostgreSQL
PGDATA=/var/lib/postgresql/$db_version/main; export PGDATA
#3. Set postgres database.
PGDATABASE=postgres; export PGDATABASE
#4. Set postgres user.
 PGUSER=postgres; export PGUSER
#5. Set postgres port.
 PGPORT=5432; export PGPORT
export TEMP=/tmp
export TMPDIR=/tmp
#umask 022


#
# PostgreSQL 14.3 alias
#
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"


#
# Load profile window
#
clear
echo "Logon Time  :  "$(date)
echo " "
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo " "
echo "        PostgreSQL   -   PostgreSQL Training   -   Module I"
echo " "
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo " "
echo "  ######                                            #####"
echo "  #     #  ####   ####  #####  ####  #####  ###### #     #  ####  #"
echo "  #     # #    # #        #   #    # #    # #      #       #    # #"
echo "  ######  #    #  ####    #   #      #    # #####   #####  #    # #"
echo "  #       #    #      #   #   #  ### #####  #            # #  # # #"
echo "  #       #    # #    #   #   #    # #   #  #      #     # #   #  #"
echo "  #        ####   ####    #    ####  #    # ######  #####   ### # ######"
echo " "
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "# "
echo "#   [ PostgreSQL 14.3  ( PostgreSQL )     /     PostgreSQL ]     "
echo "# "
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "# "
echo "# HOSTNAME    :  $HOSTNAME"
echo "# USERNAME    :  $USER"
echo "# "
echo "# "
echo "# PGDATA     :  $PGDATA"
echo "# PGDATABASE :  $PGDATABASE"
echo "# PGUSER     :  $PGUSER"
echo "# PGPORT     :  $PGPORT"
echo "# "
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo " "
