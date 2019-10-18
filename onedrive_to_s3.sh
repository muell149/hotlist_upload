#copy from onedrive
rclone copy onedrive:Charlie_LRU_NFF_Failure_Prediction.xlsx .

#convert to csv
in2csv Charlie_LRU_NFF_Failure_Prediction.xlsx > test.csv

#add quotes and remove header:
csvformat -K 1 -q "'" -U 1 test.csv > data.csv

#remove empty strings:
sed -i 's/""//g' data.csv

#finally, copy to aws s3 bucket:
#aws s3 cp --sse AES256 data.csv s3://gogo-udp-ds-prod/data/ds/reliability_hotlist/data.csv

#print what was uploaded to s3
cat data.csv

#print header
head -1 test.csv

#cleanup
rm Charlie_LRU_NFF_Failure_Prediction.xlsx
rm test.csv
rm data.csv
