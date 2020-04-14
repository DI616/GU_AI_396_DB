#!/bin/bash
echo -e [client]"\n"user=root"\n"password=root > /home/%user%/.my.cnf
mysqldump example > example-backup.sql
mysql sample < example-backup.sql
mysqldump mysql help_keyword --where="true limit 100" > limited-backup.sql
