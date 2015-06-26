#!/bin/bash

# Variables
DATAFILE="./schdist.txt"
TMPFILE="./schdist_schema_ext.tmp"
SCHEMAFILE="./schdist_schema_ext.hql"
DATADIR="/user/rkekatpure-admin/sandbox/hadooptut"
TABLE="hadooptut_schdist_ext"

# Clean up previous instances of the schema and temp files
rm -fv $SCHEMAFILE
rm -fv $TEMPFILE

# Print the 'create table' header into the schema creation file
echo "use default;
drop table $TABLE;
create external table hadooptut_schdist_ext (" > $TMPFILE

# Print column names and data types
COLUMNS=$(head -1 $DATAFILE | tr "\t" " "| tr -d '\015')
for COL in ${COLUMNS[@]}; do
    echo "$COL string,"
done >> $TMPFILE


# Remove the last comma from schema file and rewrite result to $SCHEMAFILE
cat $TMPFILE | sed '$s/,$//' > $SCHEMAFILE

# Now write the tail information
echo ")
row format delimited
fields terminated by '\t'
location '$DATADIR';" >> $SCHEMAFILE

rm -fv $TMPFILE
