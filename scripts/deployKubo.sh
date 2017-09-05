export kubo_envs=~/kubo-env
export kubo_env_name=kubo
export kubo_env_path="${kubo_envs}/${kubo_env_name}"
export kubo_cluster_name="piv-kubo"
bin/deploy_k8s ${kubo_env_path} ${kubo_cluster_name} public
bin/set_kubeconfig ${kubo_env_path} ${kubo_cluster_name}
