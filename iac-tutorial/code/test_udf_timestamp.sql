add file   /home/rkekatpure-admin/tutorials/hadooptut/udf_timestamp.py;
set mapred.job.queue.name=exp_dsa;
use iac_trinity;

select transform(s.year, s.month, s.day, s.hour) 
using 'python udf_timestamp.py' as ts 
from sbg_us_clickstream_mobile s 
where year='2015' and month='06' and day='02'
limit 100;
