#!/bin/bash

#######################################
### usage: ./onedrive_to_s3.sh
######################################

# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

echo 'copying from onedrive...'
/usr/bin/rclone copy onedrive:Charlie_LRU_NFF_Failure_Prediction.xlsx /mnt/cmueller/


echo ''
echo 'converting xlsx to csv...'
/usr/local/bin/in2csv /mnt/cmueller/Charlie_LRU_NFF_Failure_Prediction.xlsx > /mnt/cmueller/test.csv

echo ''
echo 'removing header....'
/usr/local/bin/csvformat -K 1 /mnt/cmueller/test.csv > /mnt/cmueller/data.csv

echo ''
echo 'removing any whitespace...'
sed -i 's/ //g' /mnt/cmueller/data.csv

echo ''
echo 'copying to s3 bucket...'
aws s3 cp --sse AES256 /mnt/cmueller/data.csv s3://gogo-udp-ds-prod/data/ds/reliability_hotlist/data.csv

echo ''
echo 'contents uploaded to s3:'
cat /mnt/cmueller/data.csv

echo ''
echo 'header:'
head -1 /mnt/cmueller/test.csv

echo ''
echo 'cleaning up (deleting) copied files...'
rm /mnt/cmueller/Charlie_LRU_NFF_Failure_Prediction.xlsx
rm /mnt/cmueller/test.csv
rm /mnt/cmueller/data.csv

echo ''
echo 'done.'
