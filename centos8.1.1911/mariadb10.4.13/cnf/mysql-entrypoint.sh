#!/bin/bash
set -eo pipefail

cd /usr/local/mysql

if [ ! -d /var/lib/mysql/mysql ]; then
        echo 'The database is being initialized. Please wait for the...'
        scripts/mysql_install_db --defaults-file=/etc/mysql/my.cnf --auth-root-authentication-method=normal --skip-test-db &> /dev/null

        bin/mysqld &
        pid="$!"

        mysql=( bin/mysql -uroot -hlocalhost )

        for i in {30..0}; do
                if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
                        break
                fi
                echo 'MySQL init process in progress...'
                sleep 1
        done
        if [ "$i" = 0 ]; then
                echo >&2 'MySQL init process failed.'
                exit 1
        fi

        echo 'MYSQL is importing time zone information...'
        bin/mysql_tzinfo_to_sql /usr/share/zoneinfo/right | "${mysql[@]}" mysql

        "${mysql[@]}" <<-EOSQL
                DELETE FROM mysql.user WHERE host != 'localhost' ;
                FLUSH PRIVILEGES ;
EOSQL

        if ! kill -s TERM "$pid" || ! wait "$pid"; then
                echo >&2 'MySQL init process failed.'
                exit 1
        fi

        echo 'MySQL init process done. Ready for start up.'
fi

bin/mysqld_safe