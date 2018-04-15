#!/bin/bash
# date: 2017-11-24
# kubernetes 1.7.5 on centos7  

KUBE_VERSION="v1.8.4"

echo "disable swap"
sed -i 's/^.*swap/#&/' /etc/fstab || true
swapoff -a

echo "add kubernetes repo "
cat << 'EOF' > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0
EOF

echo "pull and tag docker images"
docker pull mirrorgooglecontainers/kube-apiserver-amd64:${KUBE_VERSION}
docker pull mirrorgooglecontainers/kube-controller-manager-amd64:${KUBE_VERSION}
docker pull mirrorgooglecontainers/kube-scheduler-amd64:${KUBE_VERSION}
docker pull mirrorgooglecontainers/kube-proxy-amd64:${KUBE_VERSION}
docker pull mirrorgooglecontainers/k8s-dns-sidecar-amd64:1.14.4
docker pull mirrorgooglecontainers/k8s-dns-kube-dns-amd64:1.14.4
docker pull mirrorgooglecontainers/k8s-dns-dnsmasq-nanny-amd64:1.14.4
docker pull mirrorgooglecontainers/etcd-amd64:3.0.17
docker pull mirrorgooglecontainers/pause-amd64:3.0
docker pull quay.io/coreos/flannel:v0.9.1-amd64

docker tag mirrorgooglecontainers/kube-apiserver-amd64:${KUBE_VERSION} gcr.io/google_containers/kube-apiserver-amd64:${KUBE_VERSION}
docker tag mirrorgooglecontainers/kube-controller-manager-amd64:${KUBE_VERSION} gcr.io/google_containers/kube-controller-manager-amd64:${KUBE_VERSION}
docker tag mirrorgooglecontainers/kube-scheduler-amd64:${KUBE_VERSION} gcr.io/google_containers/kube-scheduler-amd64:${KUBE_VERSION}
docker tag mirrorgooglecontainers/kube-proxy-amd64:${KUBE_VERSION} gcr.io/google_containers/kube-proxy-amd64:${KUBE_VERSION}
docker tag mirrorgooglecontainers/k8s-dns-sidecar-amd64:1.14.4 gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.5
docker tag mirrorgooglecontainers/k8s-dns-kube-dns-amd64:1.14.4 gcr.io/google_containers/k8s-dns-kube-dns-amd64:1.14.5
docker tag mirrorgooglecontainers/k8s-dns-dnsmasq-nanny-amd64:1.14.4 gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64:1.14.5
docker tag mirrorgooglecontainers/etcd-amd64:3.0.17 gcr.io/google_containers/etcd-amd64:3.0.17
docker tag mirrorgooglecontainers/pause-amd64:3.0 gcr.io/google_containers/pause-amd64:3.0

echo "Installing kubeadm, kubelet and kubectl"
yum update -y
yum install -y kubelet kubeadm kubectl

#kubernetes-cni
#socat
#curl -o /usr/bin/kubectl https://github.com/bin/kubectl-${KUBE_VERSION}
#curl -o /usr/bin/kubeadm https://
#curl -o /usr/bin/kubelet https://

mkdir -p /etc/kubernetes/manifests || true

cat << 'EOF' > /etc/systemd/system/kubelet.service
[Unit]
Description=kubelet: The Kubernetes Node Agent
Documentation=http://kubernetes.io/docs/

[Service]
ExecStart=/usr/bin/kubelet
Restart=always
StartLimitInterval=0
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

cat << 'EOF' > /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
[Service]
Environment="KUBE_KUBERNETES_DIR=/etc/kubernetes"
Environment="KUBE_ETCD_IMAGE=mirrorgooglecontainers/etcd-amd64:3.2.9"
#Environment="KUBE_REPO_PREFIX=registry.cn-beijing.aliyuncs.com/gcr-google-containers"
Environment="KUBE_HYPERKUBE_IMAGE=mirrorgooglecontainers/hyperkube-amd64:v1.8.4"
Environment="KUBE_DISCOVERY_IMAGE=mirrorgooglecontainers/kube-discovery-amd64:1.0"
Environment="KUBELET_KUBECONFIG_ARGS=--kubeconfig=/etc/kubernetes/kubelet.conf --require-kubeconfig=true"
Environment="KUBELET_SYSTEM_PODS_ARGS=--pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true"
Environment="KUBELET_NETWORK_ARGS=--network-plugin=cni --cni-conf-dir=/etc/cni/net.d --cni-bin-dir=/opt/cni/bin"
Environment="KUBELET_DNS_ARGS=--cluster-dns=10.96.0.10 --cluster-domain=cluster.local"
Environment="KUBELET_AUTHZ_ARGS=--authorization-mode=Webhook --client-ca-file=/etc/kubernetes/pki/ca.crt"
Environment="KUBELET_CADVISOR_ARGS=--cadvisor-port=0"
Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=cgroupfs"
Environment="KUBELET_EXTRA_ARGS=--pod-infra-container-image=mirrorgooglecontainers/pause-amd64:3.0"
ExecStart=
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_SYSTEM_PODS_ARGS $KUBELET_NETWORK_ARGS $KUBELET_DNS_ARGS $KUBELET_AUTHZ_ARGS $KUBELET_CADVISOR_ARGS $KUBELET_CGROUP_ARGS $KUBELET_EXTRA_ARGS
EOF

systemctl daemon-reload
systemctl enable kubelet && systemctl restart kubelet
