export demo_home=${PWD}
export prefix=s1p-pks- ##ADD A PREFIX FOR GCP OBJECTS SUCH AS TEST-
export network=s1p-pks-net ## ADD NAME OF NETWORK
export subnet_ip_prefix="192.168.5" # Your subnet pref
export project_id=$(gcloud config get-value project)
export region=us-east1 # region that you will deploy Kubo in
export zone=us-east1-b # zone that you will deploy Kubo in
export service_account_email=${prefix}terraform@${project_id}.iam.gserviceaccount.com
