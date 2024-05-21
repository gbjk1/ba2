#!/bin/bash
kubeadm join 192.168.20.3:6443 --token [token from kubeadm init] --discovery-token-ca-cert-hash [token from kubeadm init]