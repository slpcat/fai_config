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
done

#quay_image_files=(
#./kubespray/roles/download/defaults/main.yml
#./kubespray/roles/etcd/tasks/install_rkt.yml
#./kubespray/roles/kubernetes/node/tasks/install_rkt.yml
#./kubespray/roles/kubernetes/node/defaults/main.yml
#)

#for file in ${quay_image_files[@]} ; do
#    sed -i "s/quay.io\/coreos\//${PRIVATE_QUAYIO_REGISTRY}\/coreos-/g" $file
#    sed -i "s/quay.io\/calico\//${PRIVATE_QUAYIO_REGISTRY}\/calico-/g" $file
#    sed -i "s/quay.io\/l23network\//${PRIVATE_QUAYIO_REGISTRY}\/l23network-/g" $file
#done
sed -i 's/gcr.io\/kubernetes-helm/slpcat/' ./kubespray/roles/download/defaults/main.yml
#disable docker install
sed -i '/role:\ docker/d' ./kubespray/cluster.yml 
#./kubespray/roles/docker/tasks/main.yml

#change cluster congfig
sed -i '/ndots/ndots:\ 5/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/kube_proxy_mode/kube_proxy_mode:\ ipvs/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/efk_enabled/efk_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml 
sed -i '/helm_enabled/helm_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/istio_enabled/istio_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/local_volume_provisioner_enabled/local_volume_provisioner_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/ingress_nginx_enabled/ingress_nginx_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/kubeconfig_localhost/kubeconfig_localhost:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml

#change EFK config
#./kubespray/roles/kubernetes-apps/efk/kibana/templates/kibana-deployment.yml.j2

#change etcd config
sed -i "s/^etcd_extra_vars.*$/etcd_extra_vars\:\ \{\ --quota-backend-bytes=16G\ \}/" ./kubespray/roles/etcd/defaults/main.yml

#kubelet tuning https://kubernetes.io/docs/reference/generated/kubelet/
# 
#roles/kubernetes/node/templates/kubelet.standard.env.j2
#roles/kubernetes/node/defaults/main.yml
sed -i "s/kubelet_custom_flags.*$/kubelet_custom_flags\:\ \[\ --dynamic-config-dir=\'\/var\/lib\/kubelet\/conf\'\ --event-burst=50\ --event-qps=30\ --experimental-allowed-unsafe-sysctls=\'kernel\.msg\*,net\.\*\'\ --http-check-frequency=20\ --image-gc-high-threshold=80\ --image-gc-low-threshold=40\ --image-pull-progress-deadline=2h\ --kube-api-burst=2000\ --kube-api-qps=1000\ --max-pods=200\ --minimum-image-ttl-duration=72h\ -–node-status-update-frequency=20s\ --node-monitor-period=10\ --node-monitor-grace-period=2m\ --pods-per-core=50\ --protect-kernel-defaults=false\ --registry-burst=20\ --registry-qps=10\ --serialize-image-pulls=false\ --terminated-pod-gc-threshold=12500\ \]/" ./kubespray/roles/kubernetes/node/defaults/main.yml
