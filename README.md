Scripts to copy files from onedrive to aws s3 running from EMR cluster.

See: https://inside.gogoair.com/pages/viewpage.action?pageId=146543164 and https://inside.gogoair.com/display/Qty/Pyspark-Jupyter+EMR+Resource+Usage+Notes#Pyspark-JupyterEMRResourceUsageNotes-HowtosetupautomatedcopyfromonedrivetoS3

for more info. populates the ds.reliability_hotlist table.

Relies on:

- https://github.com/rclone/rclone
- https://github.com/wireservice/csvkit


Usage:

./onedrive_to_s3.sh