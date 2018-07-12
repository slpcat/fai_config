#!/bin/bash
#sync all images for kubernetes v1.10.4 to private registry
set -o errexit
set -o nounset
set -o pipefail

#GCR_REGISTRY="gcr.io/google_containers"
GCR_REGISTRY="mirrorgooglecontainers"
PRIVATE_KUBE_REGISTRY="slpcat"

images=(
cluster-proportional-autoscaler-amd64:1.1.2
k8s-dns-sidecar-amd64:1.14.10
k8s-dns-kube-dns-amd64:1.14.10
k8s-dns-dnsmasq-nanny-amd64:1.14.10
pause-amd64:3.0
kubernetes-dashboard-amd64:v1.8.3
fluentd-elasticsearch:v2.0.4
elasticsearch:v5.6.4
heapster-amd64:v1.4.0
heapster-grafana-amd64:v4.4.1
heapster-influxdb-amd64:v1.1.1
hyperkube:v1.10.4
defaultbackend:1.4
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
coreos/etcd:v3.2.18
coreos/flannel:v0.10.0
coreos/flannel-cni:v0.3.0
calico/kube-controllers:v1.0.3
calico/ctl:v1.6.3
calico/node:v2.6.8
calico/cni:v1.11.4
calico/routereflector:v0.4.2
external_storage/local-volume-provisioner:v2.0.0
kubespray/cephfs-provisioner:v1.1.0-k8s1.10
kubernetes-ingress-controller/nginx-ingress-controller:0.16.2
jetstack/cert-manager-controller:v0.3.2
jetstack/cert-manager-ingress-shim:v0.3.2
l23network/k8s-netchecker-agent:v1.2.2
l23network/k8s-netchecker-server:v1.2.2
)

for imageName in ${images[@]} ; do
  docker pull ${QUAY_REGISTRY}/$imageName
  docker tag ${QUAY_REGISTRY}/$imageName ${PRIVATE_QUAYIO_REGISTRY}/${imageName/\//-}
  docker push ${PRIVATE_QUAYIO_REGISTRY}/${imageName/\//-}
  docker rmi ${PRIVATE_QUAYIO_REGISTRY}/${imageName/\//-}
done

HELM_VERSION=v2.9.1
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:${HELM_VERSION}
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:${HELM_VERSION} slpcat/tiller:${HELM_VERSION}
docker push slpcat/tiller:${HELM_VERSION}
docker rmi slpcat/tiller:${HELM_VERSION}

KIBANA_VERSION=5.6.4
docker pull docker.elastic.co/kibana/kibana:${KIBANA_VERSION}
docker tag docker.elastic.co/kibana/kibana:${KIBANA_VERSION} slpcat/kibana:${KIBANA_VERSION}
docker push slpcat/kibana:${KIBANA_VERSION}
docker rmi slpcat/kibana:${KIBANA_VERSION}


#gcr.io/kubernetes-helm/tiller:v2.7.0
#images=(
#weaveworks/weave-kube:2.0.5
#weaveworks/weave-npc:2.0.5
#andyshinn/dnsmasq:2.78
#lachlanevenson/k8s-helm:2.7.0
#xueshanf/install-socat:latest
#vault:0.8.1
#nginx:1.11.4-alpine
