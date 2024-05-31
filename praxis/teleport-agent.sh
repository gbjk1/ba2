#!/bin/bash

kubectl create namespace teleport-agent

helm repo add teleport https://charts.releases.teleport.dev 
helm repo update
helm helm install teleport-agent teleport/teleport-kube-agent -f nebhis-cluster-values.yaml --version 14.3.3 --create-namespace --namespace teleport-agent