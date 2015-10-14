for DB in $(hive -e "show databases;" 2>/dev/null); do
    for TBL in $(hive -e "use $DB; show tables;" 2>/dev/null); do
        echo ${DB}.${TBL}
    done
done