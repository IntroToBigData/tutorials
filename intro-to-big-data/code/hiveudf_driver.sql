-- Driver for the hiveudf. Invokation:
-- $ hive -f hiveudf_driver.sql


add file /home/rkekatpure-admin/sandbox/tutorials/hiveudf.py;
set mapred.job.ququq.name=exp_dsa;

use ibd2015;
select transform(ibd.userid, ibd.state, ibd.message)
using 'python hiveudf.py'
from ibd2015random ibd
limit 100;

