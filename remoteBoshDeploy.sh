source ./remoteSetupEnv.sh


# THIS SCRIPT RUNS ON THE BOSH BASTION HOST
cd /share/kubo-deployment
./bin/generate_env_config "${kubo_envs}" ${kubo_env_name} gcp
/usr/bin/update_gcp_env "${kubo_env_path}/director.yml"
./bin/deploy_bosh "${kubo_env_path}" ~/terraform.key.json
