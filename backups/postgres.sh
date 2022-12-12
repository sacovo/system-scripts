#!/usr/bin/sh

REPOSITORY=
DB_SERVER=

backup_db() {
	local database=$1
	local filename="$database.sql"

	echo "Backup $database to $filename using user $user"

	ssh $DB_SERVER sudo -u postgres pg_dump $database --no-comments --clean --format=custom | restic -r "$REPOSITORY/postgres" backup --stdin --stdin-filename $filename --tag db
}


backup_db db-name dump-name
