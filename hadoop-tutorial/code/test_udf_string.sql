add file /home/rkekatpure-admin/tutorials/hadooptut/udf_string.py;
set mapred.job.queue.name=exp_dsa;

select transform(hd.name, hd.mcity) 
using 'python udf_string.py' as ts 
from hadooptut_schdist_ext hd
limit 100;
