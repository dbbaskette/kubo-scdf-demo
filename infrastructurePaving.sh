export demo_home=${PWD}
export prefix=s1p-pks- ##ADD A PREFIX FOR GCP OBJECTS SUCH AS TEST-
export network=pks-net ## ADD NAME OF NETWORK
export subnet_ip_prefix="10.0.1" # Your subnet pref
export project_id=$(gcloud config get-value project)
export region=us-east1 # region that you will deploy Kubo in
export zone=us-east1-b # zone that you will deploy Kubo in
export service_account_email=${prefix}terraform@${project_id}.iam.gserviceaccount.com
gcloud compute networks create ${network} --mode=custom
gcloud config set compute/zone ${zone}
gcloud config set compute/region ${region}
gcloud iam service-accounts create ${prefix}terraform
gcloud iam service-accounts keys create ${demo_home}/terraform.key.json --iam-account ${service_account_email}
gcloud projects add-iam-policy-binding ${project_id} --member serviceAccount:${service_account_email} --role roles/owner
export GOOGLE_CREDENTIALS=$(cat ${demo_home}/terraform.key.json)
git clone https://github.com/cloudfoundry-incubator/kubo-deployment.git
cd ${demo_home}/kubo-deployment/docs/user-guide/platforms/gcp
docker run -i -t -v $(pwd):/$(basename $(pwd)) -w /$(basename $(pwd)) hashicorp/terraform:light init
docker run -i -t -e CHECKPOINT_DISABLE=1 -e "GOOGLE_CREDENTIALS=${GOOGLE_CREDENTIALS}" -v $(pwd):/$(basename $(pwd)) -w /$(basename $(pwd)) hashicorp/terraform:light apply \
    -var service_account_email=${service_account_email} \
    -var projectid=${project_id} \
    -var network=${network} \
    -var region=${region} \
    -var prefix=${prefix} \
    -var zone=${zone} \
    -var subnet_ip_prefix=${subnet_ip_prefix}

sleep 60
gcloud compute scp ${demo_home}/terraform.key.json "${prefix}bosh-bastion":./ --zone ${zone}

