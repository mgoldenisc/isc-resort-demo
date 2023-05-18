#!/bin/bash
set -e

mysql -uroot -p"$MYSQL_ROOT_PASSWORD"<<-EOSQL
	USE mysql;
	CREATE TABLE activereservations(res_no INT primary key, room_no INT, guest_id INT, rate NUMERIC(6,2), check_in_date DATE, check_out_date DATE, check_in_time TIME, check_out_time TIME);
	LOAD DATA INFILE '/var/lib/mysql-files/reservations.csv' INTO TABLE activereservations FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
EOSQL
