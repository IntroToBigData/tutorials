#!/bin/sh
NZ_USER="rkekatpure"
NZ_PASSWD="EIu#WXRXaf"
NZ_CREDENTIALS="-host qysprdntzdb05.data.bos.intuit.net -port 5480 -d UED_QBO_WS -u $NZ_USER -pw $NZ_PASSWD"

declare -a BENCHMARK_TABLES=("GEMINI_BENCHMARK_TABLE_1M" \
                             "GEMINI_BENCHMARK_TABLE_10M" \
                             "GEMINI_BENCHMARK_TABLE_100M")

# Execute benchmark queries
for BTABLE in "${BENCHMARK_TABLES[@]}"
do
    BENCHMARK_QUERY="SELECT COUNT(1) FROM $BTABLE"
    RESULTS=`nzsql ${NZ_CREDENTIALS} -eXAtc "${BENCHMARK_QUERY}"`
    echo -e $RESULTS
done

# Compute metrics for the benchmark queries and insert into GEMINI_BENCHMARK_RESULTS
METRICS_TABLE="_v_qryhist"
BENCHMARK_RESULTS_TABLE="GEMINI_BENCHMARK_RESULTS"

for BTABLE in "${BENCHMARK_TABLES[@]}"
do

    METRICS_QUERY=" insert into $BENCHMARK_RESULTS_TABLE
                    select  (case when true then '$BTABLE' end) as benchmark_table,
                    qh_sql as benchmark_query,
                    qh_tsubmit + (select tzoffset from _v_pg_time_offset),
                    qh_tstart + (select tzoffset from _v_pg_time_offset),
                    qh_tend + (select tzoffset from _v_pg_time_offset),

                    ( extract ( days    from ( qh_tstart::timestamp - qh_tsubmit::timestamp ) ) * 86400::bigint ) +
                    ( extract ( hours   from ( qh_tstart::timestamp - qh_tsubmit::timestamp ) ) *  3600::bigint ) +
                    ( extract ( minutes from ( qh_tstart::timestamp - qh_tsubmit::timestamp ) ) *    60::bigint ) +
                    ( extract ( seconds from ( qh_tstart::timestamp - qh_tsubmit::timestamp ) )                 )    AS queued_seconds,

                    ( extract ( days    from ( qh_tend::timestamp   - qh_tstart::timestamp  ) ) * 86400::bigint ) +
                    ( extract ( hours   from ( qh_tend::timestamp   - qh_tstart::timestamp  ) ) *  3600::bigint ) +
                    ( extract ( minutes from ( qh_tend::timestamp   - qh_tstart::timestamp  ) ) *    60::bigint ) +
                    ( extract ( seconds from ( qh_tend::timestamp   - qh_tstart::timestamp  ) )                 )    AS elapsed_seconds

                    from _v_qryhist
                    where lower(qh_user) = '$NZ_USER'
                    and upper(qh_sql) = 'SELECT COUNT(1) FROM $BTABLE'
                    order by QH_TSUBMIT desc
                    limit 1"

    nzsql ${NZ_CREDENTIALS} -qXtc "${METRICS_QUERY}"
done

# Graphite reporting
#GRAPHITE_SERVER=oprdmetas300.corp.intuit.net
GRAPHITE_SERVER="oprdmetas300.corp.intuit.net"
GRAPHITE_PORT=2003
for BTABLE in "${BENCHMARK_TABLES[@]}"
do
    GRAPHITE_QUERY="select starttime, queued_seconds, execution_seconds \
                    from GEMINI_BENCHMARK_RESULTS
                    where upper(benchmark_table)='$BTABLE'
                    order by submittime desc
                    limit 1"
    GRAPHITE_DATA=`nzsql ${NZ_CREDENTIALS} -qXtc "${GRAPHITE_QUERY}"`

    # Extract the different fields, remove trailing and leading spaces.
    STARTTIME=`echo "$GRAPHITE_DATA" | \
               cut -d"|" -f1 | \
               sed -E "s/[[:space:]]{2,}//" | \
               sed -E "s/^[[:space:]]//" | \
               sed -E "s/[[:space:]]$//" | \
               date '+%s'`

    QUEUED_SECONDS=`echo "$GRAPHITE_DATA" | cut -d"|" -f2 | sed -E "s/[[:space:]]+//" | sed -E "s/[[:space:]]$//"`
    EXECUTION_SECONDS=`echo "$GRAPHITE_DATA" | cut -d"|" -f3 | sed -E "s/[[:space:]]+//" |  sed -E "s/[[:space:]]$//"`

    echo "$STARTTIME, $QUEUED_SECONDS, $EXECUTION_SECONDS"
    echo "gemini.nzbenchmark.latency.$BTABLE $QUEUED_SECONDS $STARTTIME" | nc ${GRAPHITE_SERVER} ${GRAPHITE_PORT}
    echo "gemini.nzbenchmark.duration.$BTABLE $EXECUTION_SECONDS $STARTTIME" | nc ${GRAPHITE_SERVER} ${GRAPHITE_PORT}
done

# Database access statistics