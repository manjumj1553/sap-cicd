#!/usr/bin/sh
# Check parameters
if [ $# -ne 1 ]; then
 echo "Usage: $0 <Secure User Store Key Name>"
 exit 1
else
 USRKEY=$1
 shift
fi
# Variables
source ~/.sapenv.sh
LoggerTag=HANA-Backups
MyName=$(basename $0 .sh)
HDBCMD="hdbsql -U ${USRKEY} -quiet -j -a -x "
# Check if primary database
ISPRIMARY=$(hdbnsutil -sr_state |grep -E '^mode:\s+'|cut -d':' -f2|xargs echo)
if [ "${ISPRIMARY}" != "primary" ]; then
 if [ "${ISPRIMARY}" != "none" ]; then
 echo "Warning: Not a primary or standalone database."
 logger -t ${LoggerTag} "Warning - ${MyName}: Not a primary or standalone database."
 exit 1
 fi
fi
# Test connection to database
DBDATE=$(${HDBCMD} "SELECT CURRENT_DATE \"current date\" from dummy" 2>/dev/null|xargs echo)
if [ -z ${DBDATE} ]; then
 echo "Error: Connection to database not possible"
 logger -t ${LoggerTag} "Error - ${MyName}: Connection to database not possible."
 exit 1
fi
# Get all active databases
DATABASES=( $(${HDBCMD} "select database_name from m_databases where active_status='YES'"|xargs echo) )
i=0
for NAME in "${DATABASES[@]}"
do
 echo "Info: Starting ${NAME} backup."
 logger -t ${LoggerTag} "Info - ${MyName}: Starting ${NAME} backup."
 if [ "${NAME}" = "SYSTEMDB" ]; then
  ${HDBCMD} "backup data using backint ('$(date '+%Y_%m_%d_%H_%M')_BACKUP_FILE')"
 else
  ${HDBCMD} "backup data for ${NAME} using backint ('$(date '+%Y_%m_%d_%H_%M')_BACKUP_FILE')"
 fi
 DATABASES[$i]="${NAME}=$?"
 let i=${i}+1
done
# Check status of backup command
for RESULT in "${DATABASES[@]}"
do
 NAME=$(echo ${RESULT}|cut -d"=" -f1)
 BRC=$(echo ${RESULT}|cut -d"=" -f2)
 if [ "${BRC}" != "0" ]; then
  echo "Error: ${NAME} backup not successfull"
  logger -t ${LoggerTag} "Error - ${MyName}: ${NAME} backup not successfull."
 else
  echo "Info: ${NAME} backup completed successfully"
  logger -t ${LoggerTag} "Info - ${MyName}: ${NAME} backup completed successfully."
 fi
done
#### Delete backup older than 14 days #####
hdbsql -o /tmp/sysdb.out -a -x -U $USRKEY "select database_name, max(backup_id) from sys_databases.m_backup_catalog where sys_end_time < add_days(current_date, -14) and entry_type_name='complete data backup' group by database_name"
cat /tmp/sysdb.out | sed -e 's/"/ /g' -e 's/,/ /g' | while read f1 f2
do
#  echo "BACKUP CATALOG DELETE FOR $f1 ALL BEFORE BACKUP_ID $f2 COMPLETE"
  hdbsql -x -U $USRKEY "BACKUP CATALOG DELETE FOR $f1 ALL BEFORE BACKUP_ID $f2 COMPLETE"
done
