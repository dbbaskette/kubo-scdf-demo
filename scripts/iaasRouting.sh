cd /share/kubo-deployment/docs/user-guide/routing/gcp
export kubo_env_name=kubo
export state_dir=~/kubo-env/${kubo_env_name}
export kubo_terraform_state=${state_dir}/terraform.tfstate
terraform apply \
    -var network=${network} \
    -var projectid=${project_id} \
    -var region=${region} \
    -var prefix=${prefix} \
    -var ip_cidr_range="${subnet_ip_prefix}.0/24" \
    -state=${kubo_terraform_state}
export master_target_pool=$(terraform output -state=${kubo_terraform_state} kubo_master_target_pool) # master_target_pool                                                                             
export kubernetes_master_host=$(terraform output -state=${kubo_terraform_state} master_lb_ip_address) # kubernetes_master_host
/usr/bin/set_iaas_routing "${state_dir}/director.yml"
