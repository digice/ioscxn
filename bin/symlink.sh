#!/bin/sh

# Symbolic Link examples

# EXAMPLE 1

# Repo is in /var/www/app and web root is /var/www/html
# ln -s /var/www/app/ioscxn/www /var/www/html/ioscxn

# or use relative path
# ln -s ../app/ioscxn/www /var/www/html/ioscxn

# EXAMPLE 2

# Repo is in /Users/username/Developer and web root is in /Library/WebServer/Documents
# ln -s /Users/username/Developer/ioscxn/www /Library/WebServer/Documents/ioscxn

# or use relative path
# ln -s ../../../Users/digices/Developer/ioscxn/www /Library/WebServer/Documents/ioscxn
