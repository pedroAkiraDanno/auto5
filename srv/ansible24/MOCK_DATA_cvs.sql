--https://www.mockaroo.com/
--https://www.enterprisedb.com/postgres-tutorials/how-import-and-export-data-using-csv-files-postgresql


\copy mockaroo_cvs from '/var/lib/postgresql/scripts/MOCK_DATA.csv' delimiter ',' csv header;