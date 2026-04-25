#/bin/bash
lsnrctl stop
sqlplus / nolog @shutdown.sql