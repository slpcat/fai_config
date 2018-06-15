#!/bin/bash
set -ex

#clone code
git clone https://github.com/kubernetes-incubator/kubespray

#change to the tested version
cd kubespray
git checkout 6ac601fd2dab16b51d3ac23ae8ef2c66ac718e64
cd ..

#change to private registry 
# current dir contains "kubespray"
PRIVATE_KUBE_REGISTRY="slpcat"
PRIVATE_QUAYIO_REGISTRY="slpcat"
gcr_image_files=(
./kubespray/roles/kubernetes-apps/ansible/defaults/main.yml
./kubespray/roles/download/defaults/main.yml
)

for file in ${gcr_image_files[@]} ; do
    sed -i "s/gcr.io\/google_containers/${PRIVATE_KUBE_REGISTRY}/g" $file
    sed -i "s/gcr.io\/google-containers/${PRIVATE_KUBE_REGISTRY}/g" $file
done

quay_image_files=(
./kubespray/roles/download/defaults/main.yml
./kubespray/roles/etcd/tasks/install_rkt.yml
./kubespray/roles/kubernetes/node/tasks/install_rkt.yml
./kubespray/roles/kubernetes/node/defaults/main.yml
)

for file in ${quay_image_files[@]} ; do
    sed -i "s/quay.io\/coreos\//${PRIVATE_QUAYIO_REGISTRY}\/coreos-/g" $file
    sed -i "s/quay.io\/calico\//${PRIVATE_QUAYIO_REGISTRY}\/calico-/g" $file
    sed -i "s/quay.io\/l23network\//${PRIVATE_QUAYIO_REGISTRY}\/l23network-/g" $file
    sed -i "s/quay.io\/external_storage\//${PRIVATE_QUAYIO_REGISTRY}\/external_storage-/g" $file
    sed -i "s/quay.io\/kubespray\//${PRIVATE_QUAYIO_REGISTRY}\/kubespray-/g" $file
    sed -i "s/quay.io\/jetstack\//${PRIVATE_QUAYIO_REGISTRY}\/jetstack-/g" $file
    sed -i "s/quay.io\/kubernetes-ingress-controller\//${PRIVATE_QUAYIO_REGISTRY}\/kubernetes-ingress-controller-/g" $file
done

sed -i 's/gcr.io\/kubernetes-helm/slpcat/' ./kubespray/roles/download/defaults/main.yml

#disable docker install
sed -i '/role:\ docker/d' ./kubespray/cluster.yml 
#./kubespray/roles/docker/tasks/main.yml

#change gather_timeout
#  pre_tasks:
#    - name: gather facts from all instances
#      setup:
#              gather_timeout: 90

#change cluster congfig
sed -i 's/^ndots.*$/ndots:\ 5/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
sed -i 's/^kube_proxy_mode.*$/kube_proxy_mode:\ ipvs/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
sed -i 's/^efk_enabled.*$/efk_enabled:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml 
#sed -i 's/^helm_enabled.*$/helm_enabled:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
#sed -i 's/^istio_enabled.*$/istio_enabled:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
#rbd-provisioner work with kube_dns
#sed -i 's/^dns_mode.*$/dns_mode:\ coredns_dual/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
sed -i 's/^kube_version.*$/kube_version:\ v1.10.4/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
sed -i 's/^local_volume_provisioner_enabled.*$/local_volume_provisioner_enabled:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
sed -i 's/^ingress_nginx_enabled.*$/ingress_nginx_enabled:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
sed -i 's/^#\ ingress_nginx_host_network.*$/ingress_nginx_host_network:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
sed -i 's/^kubeconfig_localhost.*$/kubeconfig_localhost:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
#sed -i 's/^#\ kubelet_enforce_node_allocatable.*$/kubelet_enforce_node_allocatable:\ kube-reserved/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
#sed -i 's/^#kube_token_auth.*$/kube_token_auth:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml
sed -i 's/^#\ kubeconfig_localhost.*$/kubeconfig_localhost:\ true/' ./kubespray/inventory/sample/group_vars/k8s-cluster.yml

sed -i 's/^#kube_read_only_port.*$/kube_read_only_port:\ 10255/' ./kubespray/inventory/sample/group_vars/all.yml
sed -i 's/^#kubelet_load_modules.*$/kubelet_load_modules:\ true/' ./kubespray/inventory/sample/group_vars/all.yml
sed -i 's/^cert_manager_enabled.*$/cert_manager_enabled:\ true/ ' ./kubespray/inventory/sample/group_vars/all.yml
sed -i 's/^#etcd_memory_limit.*$/etcd_memory_limit:\ "0"/' ./kubespray/inventory/sample/group_vars/all.yml
sed -i 's/^etcd_events_cluster_setup.*$/etcd_events_cluster_setup:\ true/' ./kubespray/roles/kubespray-defaults/defaults/main.yaml

#change EFK config
#./kubespray/roles/kubernetes-apps/efk/kibana/templates/kibana-deployment.yml.j2
#sed -i /kibana_base_url/d  ./kubespray/roles/kubernetes-apps/efk/kibana/templates/kibana-deployment.yml.j2
#sed -i /KIBANA_BASE_URL/d  ./kubespray/roles/kubernetes-apps/efk/kibana/templates/kibana-deployment.yml.j2

#change local-volume-provisioner
echo 'reclaimPolicy: Retain' >> ./kubespray/roles/kubernetes-apps/external_provisioner/local_volume_provisioner/templates/local-volume-provisioner-sc.yml.j2

#change etcd config
#sed -i 's/^etcd_extra_vars.*$/etcd_extra_vars:\n   - ETCD_MAX_REQUEST_BYTES: "32M"\n  - ETCD_QUOTA_BACKEND_BYTES: "8G"/' ./kubespray/roles/etcd/defaults/main.yml

#Azure cloudprovider
#inventory/sample/group_vars/all.yml
#azure_cloud: AzureChinaCloud
#./roles/kubernetes/node/templates/azure-cloud-config.j2
#  "cloud": "{{ azure_cloud }}",

#kubelet tuning https://kubernetes.io/docs/reference/generated/kubelet/
# 
#roles/kubernetes/node/templates/kubelet.standard.env.j2
#roles/kubernetes/node/defaults/main.yml
sed -i 's/^kubelet_max_pods.*$/kubelet_max_pods:\ 210/' ./kubespray/roles/kubernetes/node/defaults/main.yml
sed -i 's/^kubelet_status_update_frequency.*$/kubelet_status_update_frequency:\ 20s/' ./kubespray/roles/kubernetes/node/defaults/main.yml
sed -i "s/kubelet_custom_flags.*$/kubelet_custom_flags\:\ \[--event-burst=50\ --event-qps=30\ --experimental-allowed-unsafe-sysctls=\'net.*\'\ --image-gc-high-threshold=80\ --image-gc-low-threshold=40\ --image-pull-progress-deadline=2h\ --kube-api-burst=2000\ --kube-api-qps=1000\ --minimum-image-ttl-duration=72h\ --protect-kernel-defaults=false\ --registry-burst=20\ --registry-qps=10\ --serialize-image-pulls=false\ ]/" ./kubespray/roles/kubernetes/node/defaults/main.yml

#feature_gates tuning
#GPU support --feature-gates=DevicePlugins=true
sed -i '/^kube_feature_gates/a\  - "ReadOnlyAPIDataVolumes=false"\n  - "ExpandPersistentVolumes=true"\n  - "DevicePlugins=true"' ./kubespray/roles/kubespray-defaults/defaults/main.yaml
