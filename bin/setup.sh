#!/bin/sh

STARTDIR="$(pwd)"

PACKAGE="iOSCxn"

AUTHOR="Roderic Linguri <linguri@digices.com>"

COPYRIGHT="2017 Digices LLC"

LICENSE="https://www.digices.com/license/mit.txt"

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PTH=$(dirname $BASEDIR)

# navigate to project dir
cd $PTH

# dynamically determine package name
NAMESPACE="${PWD##*/}"

# message
echo "Welcome to the $PACKAGE setup script."
echo "Your application name, database name, and user name will be \"$NAMESPACE\"."
echo "The full path to the application is $PTH."

# ask for password
echo "Choose a password for the new MySQL user \"$NAMESPACE\":"
read PASSWORD

# create the vendor dir
mkdir vendor

# navigate into vendor dir
cd vendor

# clone paqure repo
git clone https://github.com/digice/paqure.git

# run paqure setup
./paqure/bin/setup.sh

# navigate back to project directory
cd $PTH

# create the config file
printf "<?php\n\n/**\n * @package   $PACKAGE\n * @author    $AUTHOR\n * @copyright $COPYRIGHT\n * @license   $LICENSE\n **/\n \n/** $PACKAGE Configuration **/\n\nnamespace $NAMESPACE;\n\ndefine('API_KEY','9326367bd624dcefd9467db36172c007');\n\ndefine('DB_HOST','localhost');\n\ndefine('DB_NAME','$NAMESPACE');\n\ndefine('DB_USER','$NAMESPACE');\n\ndefine('DB_PASS','$PASSWORD');\n" > "$PTH/etc/config.php"

# create SQL to run on database
printf "CREATE USER '$NAMESPACE'@'%%' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nCREATE USER '$NAMESPACE'@'localhost' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nCREATE USER '$NAMESPACE'@'127.0.0.1' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nGRANT USAGE ON *.* TO '$NAMESPACE'@'%%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;\nCREATE DATABASE IF NOT EXISTS \`$NAMESPACE\`;\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'%%' IDENTIFIED BY '$PASSWORD';\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'localhost' IDENTIFIED BY '$PASSWORD';\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'127.0.0.1' IDENTIFIED BY '$PASSWORD';\n\nUSE \`$NAMESPACE\`;\n\nCREATE TABLE \`$NAMESPACE\`.\`test\` (\n  \`id\` INT(11) NOT NULL AUTO_INCREMENT,\n  \`created\` INT(11) NOT NULL,\n  \`updated\` INT(11) NOT NULL,\n  \`deleted\` INT(11) NULL,\n  \`first\` VARCHAR(40) NULL,\n  \`last\` VARCHAR(40) NULL,\n  PRIMARY KEY (\`id\`)\n) ENGINE = InnoDB;\n\n" > "$PTH/bin/create_db.sql"

# create the database
echo "Enter the password for the mysql user \"root\": (ctrl-c to cancel)"

mysql -u root -p < $PTH/bin/create_db.sql

# return to starting directory
cd $STARTDIR
