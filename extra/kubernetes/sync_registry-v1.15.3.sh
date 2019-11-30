#!/bin/bash
#docker pull gcr.azk8s.cn/google_containers/<imagename>:<version>
#sync all images for kubernetes v1.14.3 to private registry
set -o errexit
set -o nounset
set -o pipefail

#GCR_REGISTRY="gcr.io/google_containers"
#GCR_REGISTRY="mirrorgooglecontainers"
GCR_REGISTRY="gcrcontainer"
PRIVATE_KUBE_REGISTRY="slpcat"

images=(
hyperkube-amd64:v1.15.3
kube-apiserver:v1.15.3
kube-controller-manager:v1.15.3
kube-scheduler:v1.15.3
kube-proxy:v1.15.3
cluster-proportional-autoscaler-amd64:1.6.0
k8s-dns-node-cache:1.15.4
kubernetes-dashboard-amd64:v1.10.1
pause-amd64:3.1
)

for imageName in ${images[@]} ; do
  docker pull ${GCR_REGISTRY}/$imageName
  docker tag ${GCR_REGISTRY}/$imageName ${PRIVATE_KUBE_REGISTRY}/$imageName
  docker push ${PRIVATE_KUBE_REGISTRY}/$imageName
  docker rmi ${PRIVATE_KUBE_REGISTRY}/$imageName
done

QUAY_REGISTRY="quay.io"
PRIVATE_QUAYIO_REGISTRY="slpcat"

images=(
coreos/etcd:v3.3.10
coreos/flannel:v0.11.0
coreos/flannel-cni:v0.3.0
calico/kube-controllers:v3.7.3
calico/ctl:v3.7.3
calico/node:v3.7.3
calico/cni:v3.7.3
calico/routereflector:v0.6.1
external_storage/local-volume-provisioner:v2.1.0
external_storage/cephfs-provisioner:v2.1.1-k8s1.11
kubernetes-ingress-controller/nginx-ingress-controller:0.25.0
l23network/k8s-netchecker-agent:v1.2.2
l23network/k8s-netchecker-server:v1.2.2
)

for imageName in ${images[@]} ; do
  docker pull ${QUAY_REGISTRY}/$imageName
  docker tag ${QUAY_REGISTRY}/$imageName ${PRIVATE_QUAYIO_REGISTRY}/${imageName/\//-}
  docker push ${PRIVATE_QUAYIO_REGISTRY}/${imageName/\//-}
  docker rmi ${PRIVATE_QUAYIO_REGISTRY}/${imageName/\//-}
done
