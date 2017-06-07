#!/bin/sh

PACKAGE="iOSCxn"

STARTDIR="$(pwd)"

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PTH=$(dirname $BASEDIR)

# navigate to project dir
cd $PTH

# dynamically determine package name
NAMESPACE="${PWD##*/}"

# message
echo "Welcome to the iOSCxn setup script."
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

# build the database class
printf "<?php\n\n/**\n * @package   iOSCxn\n * @author    Roderic Linguri <linguri@digices.com>\n * @copyright 2017 Digices LLC\n * @license   https://digices.com/license/mit.txt\n **/\n\nnamespace ioscxn;\n\nclass Database extends \sqlayr\Database\n{\n  /** @property Database instance **/\n  protected static \$shared;\n\n  /** @method Database getter **/\n  public static function shared()\n  {\n    if (!isset(self::\$shared)) {\n      self::\$shared = new self();\n    }\n    return self::\$shared;\n  } // ./shared\n\n  /** @method constructor **/\n  public function __construct()\n  {\n    \$this->host = 'localhost';\n    \$this->name = '$NAMESPACE';\n    \$this->user = '$NAMESPACE';\n    \$this->pass = '$PASSWORD';\n    parent::__construct();\n  } // ./construct\n\n} // ./Database\n" > "$PTH/lib/database.php"

# create db_sql
printf "CREATE USER '$NAMESPACE'@'%%' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nCREATE USER '$NAMESPACE'@'localhost' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nCREATE USER '$NAMESPACE'@'127.0.0.1' IDENTIFIED WITH mysql_native_password AS '$PASSWORD';\nGRANT USAGE ON *.* TO '$NAMESPACE'@'%%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;\nCREATE DATABASE IF NOT EXISTS \`$NAMESPACE\`;\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'%%' IDENTIFIED BY '$PASSWORD';\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'localhost' IDENTIFIED BY '$PASSWORD';\nGRANT ALL PRIVILEGES ON \`$NAMESPACE\`.* TO '$NAMESPACE'@'127.0.0.1' IDENTIFIED BY '$PASSWORD';\n\nUSE \`$NAMESPACE\`;\n\nCREATE TABLE \`$NAMESPACE\`.\`test\` (\n  \`id\` INT(11) NOT NULL AUTO_INCREMENT,\n  \`created\` INT(11) NOT NULL,\n  \`updated\` INT(11) NOT NULL,\n  \`deleted\` INT(11) NULL,\n  \`first\` VARCHAR(40) NULL,\n  \`last\` VARCHAR(40) NULL,\n  PRIMARY KEY (\`id\`)\n) ENGINE = InnoDB;\n\n" > "$PTH/bin/create_db.sql"

# create the database
echo "Enter the password for the mysql user \"root\":"

mysql -u root -p < $PTH/bin/create_db.sql

# return to starting directory
cd $STARTDIR

