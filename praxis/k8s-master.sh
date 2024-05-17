#!/bin/bash

kubeadm init --pod-network-cidr=10.0.0.0/24 --apiserver-advertise-address 192.168.20.3
