/*****
 This Pig script performs the following operations:
 - load a specified input file with JSON data
 - filters all columns away EXCEPT for the 'state' column
 - groups the data by the 'state' column
 - returns a list of how many rows contained each state

 '$INPUT' and '$OUTPUT' are required parameters that need to be supplied in
  order for this script to work with Amazon's EMR (Elastic Map-Reduce) service.

 Note that there is a reducer stage in this Pig script, due to the GROUP
  statement and the subsequent SIZE() function.

 The equivalent SQL pseudo-code to this pig script would be:
  SELECT state, count(1) as cnt
    FROM input_data
   GROUP BY state ;
 *****/

input_data = LOAD '$INPUT' 
    USING JsonLoader('state:chararray, userid:chararray, message:chararray, source_timestamp:chararray') 
;

/*****
 This step is not strictly necessary. However, this is a common optimization;
  since there is a reducer phase later, Hadoop will write intermediate 
  output to disk. Thus, if you filter the data before grouping/reducing,
  less intermediate output will be written to disk.
 *****/

states_prj = FOREACH input_data GENERATE
    state
;

states_grp = GROUP states_prj BY
    state
;

/*****
 Notice that the parameter to SIZE() is 'states_prj', or the relation BEFORE 
  the data was GROUPed. For other aggregate functions such as COUNT() or 
  AVG(), the parameter will be a field in the relation, such as 'states_prj.state'.
 *****/

states_cnt = FOREACH states_grp GENERATE
    group AS state,
    SIZE(states_prj) AS cnt
;

STORE states_cnt 
    INTO '$OUTPUT/state_histogram'
;

