/*****
 This Pig script simply loads JSON data from a user-specified input file
  and fetches the first two records.

 '$INPUT' and '$OUTPUT' are required parameters that need to be supplied in
  order for this script to work with Amazon's EMR (Elastic Map-Reduce) service.

 Note that there is no reducer in this pig script, since this only loads data
  and then filters rows.
 *****/

input_data = LOAD '$INPUT' 
    USING JsonLoader('state:chararray, userid:chararray, message:chararray, source_timestamp:chararray') 
;

in01 = LIMIT input_data 2 
;

STORE in01 
    INTO '$OUTPUT/head_2'
;

