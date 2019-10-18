CREATE EXTERNAL TABLE `ds.reliability_hotlist`(
  `lru` string COMMENT 'line-replaceable-unit type', 
  `sn` string COMMENT 'lru serial number', 
  `tail` string COMMENT 'tail number', 
  `model_output` string COMMENT 'SN (serial number) of pulled box', 
  `date_added_to_hotlist` string COMMENT 'date lru was added by steve rocos to bv hotlist'
)
COMMENT 'Table for model output/bv hotlist'
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://gogo-udp-ds-prod/data/ds/reliability_hotlist/'