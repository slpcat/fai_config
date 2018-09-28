#!/bin/bash
#sync all images for kubernetes v1.11.3 to private registry
set -o errexit
set -o nounset
set -o pipefail

#GCR_REGISTRY="gcr.io/google_containers"
GCR_REGISTRY="mirrorgooglecontainers"
PRIVATE_KUBE_REGISTRY="slpcat"

images=(
cluster-proportional-autoscaler-amd64:1.1.2
k8s-dns-sidecar-amd64:1.14.11
k8s-dns-kube-dns-amd64:1.14.11
k8s-dns-dnsmasq-nanny-amd64:1.14.11
pause-amd64:3.1
kubernetes-dashboard-amd64:v1.10.0
fluentd-elasticsearch:v2.0.4
elasticsearch:v5.6.4
heapster-amd64:v1.4.0
heapster-grafana-amd64:v4.4.1
heapster-influxdb-amd64:v1.1.1
hyperkube:v1.11.3
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
calico/kube-controllers:v3.1.3
calico/ctl:v3.1.3
calico/node:v3.1.3
calico/cni:v3.1.3
calico/routereflector:v0.6.1
external_storage/local-volume-provisioner:v2.1.0
external_storage/cephfs-provisioner:v2.1.0-k8s1.11
kubernetes-ingress-controller/nginx-ingress-controller:0.19.0
jetstack/cert-manager-controller:v0.5.0
jetstack/cert-manager-ingress-shim:v0.5.0
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
