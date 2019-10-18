#!/bin/bash

### usage: ./onedrive_to_s3.sh

echo 'copying from onedrive...'
rclone copy onedrive:Charlie_LRU_NFF_Failure_Prediction.xlsx .

echo ''
echo 'converting xlsx to csv...'
in2csv Charlie_LRU_NFF_Failure_Prediction.xlsx > test.csv

echo ''
echo 'removing header....'
csvformat -K 1 test.csv > data.csv

echo ''
echo 'removing any whitespace...'
sed -i 's/ //g' data.csv

echo ''
echo 'copying to s3 bucket...'
aws s3 cp --sse AES256 data.csv s3://gogo-udp-ds-prod/data/ds/reliability_hotlist/data.csv

echo ''
echo 'contents uploaded to s3:'
cat data.csv

echo ''
echo 'header:'
head -1 test.csv

echo ''
echo 'cleaning up (deleting) copied files...'
rm Charlie_LRU_NFF_Failure_Prediction.xlsx
rm test.csv
rm data.csv

echo ''
echo 'done.'
