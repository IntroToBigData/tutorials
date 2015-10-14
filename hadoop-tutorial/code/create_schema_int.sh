#!/bin/bash

# Variables
DATAFILE="./schdist.txt"
TMPFILE="./schdist_schema_int.tmp"
SCHEMAFILE="./schdist_schema_int.hql"
TABLE="hadooptut_schdist_int"
DATAFILEPATH="/home/rkekatpure-admin/tutorials/hadooptut/schdist.txt"

# Clean up previous instances of the schema and temp files
rm -fv $SCHEMAFILE
rm -fv $TEMPFILE

# Print the 'create table' header into the schema creation file
echo "use default;
drop table $TABLE;
create table $TABLE (" > $TMPFILE

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
fields terminated by '\t';

load data local inpath '$DATAFILEPATH' 
overwrite into table $TABLE;
" >> $SCHEMAFILE

rm -fv $TMPFILE
