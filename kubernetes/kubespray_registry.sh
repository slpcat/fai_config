#!/bin/bash
#change to private registry 
# current dir contains "kubespray"
PRIVATE_KUBE_REGISTRY="slpcat"
PRIVATE_QUAYIO_REGISTRY="slpcat"
grc_image_files=(
./kubespray/roles/kubernetes-apps/ansible/defaults/main.yml
./kubespray/roles/dnsmasq/templates/dnsmasq-autoscaler.yml.j2
./kubespray/roles/download/defaults/main.yml
)

for file in ${grc_image_files[@]} ; do
    sed -i "s/gcr.io\/google_containers/${PRIVATE_KUBE_REGISTRY}/g" $file
done

quay_image_files=(
./kubespray/roles/kubernetes-apps/local_volume_provisioner/defaults/main.yml
./kubespray/roles/kubernetes/node/defaults/main.yml
./kubespray/roles/kubernetes/node/tasks/install_rkt.yml
./kubespray/roles/etcd/tasks/install_rkt.yml
./kubespray/roles/download/defaults/main.yml
)

for file in ${quay_image_files[@]} ; do
    sed -i "s/quay.io\/coreos\//${PRIVATE_QUAYIO_REGISTRY}\/coreos-/g" $file
    sed -i "s/quay.io\/calico\//${PRIVATE_QUAYIO_REGISTRY}\/calico-/g" $file
    sed -i "s/quay.io\/l23network\//${PRIVATE_QUAYIO_REGISTRY}\/l23network-/g" $file
done
sed -i 's/gcr.io\/kubernetes-helm/slpcat/' ./kubespray/roles/download/defaults/main.yml
