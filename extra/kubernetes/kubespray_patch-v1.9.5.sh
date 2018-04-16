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

#change cluster congfig
sed -i '/ndots/ndots:\ 5/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/kube_proxy_mode/kube_proxy_mode:\ ipvs/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/efk_enabled/efk_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml 
sed -i '/helm_enabled/helm_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/stio_enabled/istio_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/local_volume_provisioner_enabled/local_volume_provisioner_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/ngress_nginx_enabled/ingress_nginx_enabled:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml
sed -i '/ubeconfig_localhost/kubeconfig_localhost:\ true/' ./kubespray/inventory/local/group_vars/k8s-cluster.yml

#kubelet tuning https://kubernetes.io/docs/reference/generated/kubelet/
--allow-privileged=true
--event-burst 
--event-qps
--eviction-hard mapStringString                                                                             
--eviction-max-pod-grace-period int32                                                                       
--eviction-minimum-reclaim mapStringString                                                                 
--eviction-pressure-transition-period duration                                                              
--eviction-soft mapStringString                                                                             
--eviction-soft-grace-period mapStringString                                                                
--exit-on-lock-contention
--hairpin-mode=promiscuous-bridge
--http-check-frequency 
--image-gc-high-threshold int32                                 
--image-gc-low-threshold int32
--image-pull-progress-deadline 
--kube-api-burst
--kube-api-qps int32
--max-pods 
--minimum-image-ttl-duration duration
--pods-per-core int32                                          
--protect-kernel-defaults
--registry-burst int32                                                                                     
--registry-qps int32
--serialize-image-pulls  

