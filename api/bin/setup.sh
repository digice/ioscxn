#!/bin/sh

PACKAGE="iOSConnect"

# save path to present working directory
PATH="$(pwd)"

# dynamically determine package name
NAMESPACE="${PWD##*/}"

# message
echo "Welcome to the iOSCxn setup script."
echo "Your application name, database name, and user name will be \"$NAMESPACE\"."
echo "The full path to the application is $PATH."

# ask for password
echo "Choose a password for the new MySQL user \"$NAMESPACE\":"
read PASSWORD

# create project directories
mkdir vendor

# navigate to vendor directory
cd vendor

# clone sqlayr repo
git clone https://github.com/digice/sqlayr.git

# clone paqure repo
git clone https://github.com/digice/paqure.git

# navigate out of vendor directory
cd ../

# return to starting directory
cd $PATH

# create db_sql #
printf "CREATE USER '$NAMESPACE'@'%%' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nCREATE USER '$NAMESPACE'@'localhost' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nCREATE USER '$NAMESPACE'@'127.0.0.1' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nGRANT USAGE ON *.* TO '$NAMESPACE'@'%%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;\nCREATE DATABASE IF NOT EXISTS \`$NAMESPACE\`;\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'%%' IDENTIFIED BY '$PASSWORD';\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'localhost' IDENTIFIED BY '$PASSWORD';\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'127.0.0.1' IDENTIFIED BY '$PASSWORD';\n\nUSE \`$NAMESPACE\`;\n\nCREATE TABLE \`$NAMESPACE\`.\`test\` (\n  \`id\` INT(11) NOT NULL AUTO_INCREMENT,\n  \`created\` INT(11) NOT NULL,\n  \`updated\` INT(11) NOT NULL,\n  \`deleted\` INT(11) NULL,\n  \`first\` VARCHAR(40) NULL,\n  \`last\` VARCHAR(40) NULL,\n  PRIMARY KEY (\`id\`)\n) ENGINE = InnoDB;\n\n" > "$PTH/bin/create_db.sql"

# create the database
echo "Enter the password for the mysql user \"root\":"

mysql -u root -p < $PATH/bin/create_db.sql
