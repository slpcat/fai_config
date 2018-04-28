#!/bin/bash
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

#change cluster congfig
sed -i 's/^ndots.*$/ndots:\ 5/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i 's/^kube_proxy_mode.*$/kube_proxy_mode:\ ipvs/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i 's/^efk_enabled.*$/efk_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml 
#sed -i 's/^helm_enabled.*$/helm_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
#sed -i 's/^istio_enabled.*$/istio_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i 's/^local_volume_provisioner_enabled.*$/local_volume_provisioner_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i 's/^ingress_nginx_enabled.*$/ingress_nginx_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i 's/^kubeconfig_localhost.*$/kubeconfig_localhost:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml

#change EFK config
#./kubespray/roles/kubernetes-apps/efk/kibana/templates/kibana-deployment.yml.j2
#sed -i /kibana_base_url/d  ./kubespray/roles/kubernetes-apps/efk/kibana/templates/kibana-deployment.yml.j2
#sed -i /KIBANA_BASE_URL/d  ./kubespray/roles/kubernetes-apps/efk/kibana/templates/kibana-deployment.yml.j2


#change etcd config
sed -i 's/^etcd_extra_vars.*$/etcd_extra_vars:\n   - ETCD_MAX_REQUEST_BYTES: "32M"\n  - ETCD_QUOTA_BACKEND_BYTES: "16G"/' ./kubespray/roles/etcd/defaults/main.yml

#kubelet tuning https://kubernetes.io/docs/reference/generated/kubelet/
# 
#roles/kubernetes/node/templates/kubelet.standard.env.j2
#roles/kubernetes/node/defaults/main.yml
sed -i "s/kubelet_custom_flags.*$/kubelet_custom_flags\:\ \[--event-burst=50\ --event-qps=30\ --http-check-frequency=20s\ --image-gc-high-threshold=80\ --image-gc-low-threshold=40\ --image-pull-progress-deadline=2h\ --kube-api-burst=2000\ --kube-api-qps=1000\ --max-pods=200\ --minimum-image-ttl-duration=72h\ --node-status-update-frequency=20s\ --pods-per-core=50\ --protect-kernel-defaults=false\ --registry-burst=20\ --registry-qps=10\ --serialize-image-pulls=false\]/" ./kubespray/roles/kubernetes/node/defaults/main.yml

#feature_gates tuning
sed -i '/^kube_feature_gates/a\  - "ReadOnlyAPIDataVolumes=true"\n  - "ExpandPersistentVolumes=true"\n  - "PVCProtection=true"' ./kubespray/roles/kubespray-defaults/defaults/main.yaml
