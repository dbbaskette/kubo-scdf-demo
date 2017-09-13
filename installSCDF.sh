helm init
kubectl get po --namespace kube-system
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com
helm repo update
helm install --name scdf-release  incubator/spring-cloud-data-flow

