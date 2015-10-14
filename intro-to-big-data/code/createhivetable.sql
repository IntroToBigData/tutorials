-- Schema creation for Hive table with output of ex5 as the underlying file

-- Drop database if it exists
drop database if exists ibd2015 cascade;

-- Create database
create database ibd2015;
use ibd2015;

-- Create table
create external table ibd2015random (
    userid varchar(10),
    state varchar(50),
    message varchar(25)
)
row format delimited
fields terminated by '\u0001'
location '/user/rkekatpure-admin/ibd2015/mroutput_ex5'

