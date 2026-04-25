#/bin/bash
lsnrctl stop
sqlplus / nolog @shutdown.sql
lsnrctl start
sqlplus / nolog @startup.sql
