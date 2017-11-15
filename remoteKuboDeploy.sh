source ./remoteSetupEnv.sh

BOSH_ENV="${kubo_config_path}" source ./kubo-deployment/bin/set_bosh_environment

echo "Downloading ODB Deployment Repo"
cd /share
wget https://storage.googleapis.com/kubo-releases/kubo-odb-deployment-0.4.0-dev.28.tgz
tar xvfz kubo-odb-deployment-0.4.0-dev.28.tgz
cd /share/kubo-odb-deployment

BOSH_ENV="${kubo_config_path}" source ./kubo-deployment/bin/set_bosh_environment
bosh-cli update-cloud-config <(./kubo-deployment/bin/generate_cloud_config "${kubo_config_path}" )



echo "Downloading Kubo Release"
wget https://storage.googleapis.com/kubo-releases/kubo-0.8.0-dev.29-ubuntu-trusty-3445.11-20171010-092538-423021389-20171010092604.tgz
echo "Uploading Kubo Release to BOSH Director"
bosh-cli upload-release kubo-0.8.0-dev.29-ubuntu-trusty-3445.11-20171010-092538-423021389-20171010092604.tgz


echo "Downloading Service Adapter Release"
wget https://storage.googleapis.com/kubo-releases/kubo-service-adapter-release-0.4.0-dev.28.tgz
echo "Uploading Service Adapter Release to BOSH Director"
bosh-cli upload-release kubo-service-adapter-release-0.4.0-dev.28.tgz

echo "Downloading On-Demand Broker SDK"
wget https://s3.amazonaws.com/jaguilar-public/on-demand-service-broker-0.16.1.tgz
echo "Uploading On-Demand Broker SDK to BOSH Director"
bosh-cli upload-release on-demand-service-broker-0.16.1.tgz 

echo "Downloading Stemcell"
wget https://s3.amazonaws.com/bosh-core-stemcells/google/bosh-stemcell-3445.11-google-kvm-ubuntu-trusty-go_agent.tgz
echo "Uploading Stemcell to BOSH Director"
bosh-cli upload-stemcell bosh-stemcell-3445.11-google-kvm-ubuntu-trusty-go_agent.tgz

echo "Deploying PKS ODB"
bin/deploy_k8s_odb ${kubo_env_path} ${kubo_cluster_name} skip
