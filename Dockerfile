FROM python:alpine

ARG KUBE_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

RUN pip install awscli && \
    aws eks update-kubeconfig --name $CLUSTER_NAME --region $REGION

RUN chmod +x /entrypoint.sh && \
    apk add --no-cache --update openssl curl ca-certificates && \
    curl -o /usr/local/bin/kubectl \
      -L https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["cluster-info"]
