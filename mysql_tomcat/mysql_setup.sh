#! /bin/bash

PASSWD=password
[ -z "$1" ] || PASSWD="$1"

cat << EOF | docker-compose exec -T -- db mysql -uroot -ppassword
--default-character-set=utf8mb4
ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSWD';
CREATE USER 'admin'@'%' IDENTIFIED BY '$PASSWD';
GRANT ALL ON *.* TO 'admin'@'%';
FLUSH PRIVILEGES;
source /sqls/mysqlsampledatabase.sql;
EOF
