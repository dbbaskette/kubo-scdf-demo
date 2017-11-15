source ./remoteSetupEnv.sh

echo "Logging into CredHub"
uaa_ca=$(bosh-cli int "${kubo_config_path}/creds.yml" --path="/uaa_ssl/ca")
credhub_ca=$(bosh-cli int "${kubo_config_path}/creds.yml" --path="/credhub_tls/ca")
credhub_password=$(bosh-cli int "${kubo_config_path}/creds.yml" --path="/credhub_cli_password")
director_ip=$(bosh-cli int "${kubo_config_path}/director.yml" --path="/internal_ip")
credhub login -u credhub-cli -p ${credhub_password} -s "https://${director_ip}:8844" --ca-cert "${uaa_ca}"  --ca-cert "${credhub_ca}"

echo "Adding Information to CredHub"
director_name=$(bosh-cli interpolate "${kubo_config_path}/director.yml" --path="/director_name")

cf_sys_domain=sys.pcf.pivotaldemo.net
cf_username=admin
cf_password=p1v0tal

credhub set --name="${director_name}/${DEPLOYMENT_NAME}/cf_sys_domain" --type="value" --value="${cf_sys_domain}"
credhub set --name="${director_name}/${DEPLOYMENT_NAME}/cf_username" --type="value" --value="${cf_username}"
credhub set --name="${director_name}/${DEPLOYMENT_NAME}/cf_password" --type="value" --value="${cf_password}"

