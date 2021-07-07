#!/bin/sh

REGION=$1
CLUSTER_NAME=$2
CMD=$3

apk add --no-cache --update openssl curl ca-certificates
pip install awscli
aws eks update-kubeconfig --name $CLUSTER_NAME --region $REGION

KUBE_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -o /usr/local/bin/kubectl  \
  -L https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl
chmod +x /usr/local/bin/kubectl
rm -rf /var/cache/apk/*

kubectl $CMD
