 sudo apt-get install wget ca-certificates
 wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
 sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
 sudo apt-get update
 apt-get install postgresql-server-dev-14
 apt-get install postgresql-14-repack
 