#!/bin/bash

kubectl create namespace istio-system

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
helm install istio-base istio/base -n istio-system

kubectl create namespace istio-ingress
helm install istio-ingress istio/gateway -n istio-ingress --wait