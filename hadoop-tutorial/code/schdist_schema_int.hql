use default;
drop table hadooptut_schdist_int;
create table hadooptut_schdist_int (
SURVYEAR string,
LEAID string,
FIPST string,
STID string,
NAME string,
PHONE string,
MSTREE string,
MCITY string,
MSTATE string,
MZIP string,
MZIP4 string,
LSTREE string,
LCITY string,
LSTATE string,
LZIP string,
LZIP4 string,
TYPE string,
UNION string,
CONUM string,
CONAME string,
CSA string,
CBSA string,
METMIC string,
ULOCAL string,
CDCODE string,
LATCOD string,
LONCOD string,
BOUND string,
GSLO string,
GSHI string
)
row format delimited 
fields terminated by '\t';

load data local inpath '/home/rkekatpure-admin/tutorials/hadooptut/schdist.txt' 
overwrite into table hadooptut_schdist_int;

