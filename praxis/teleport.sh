#!/bin/bash

#Download Teleport's PGP public key
sudo curl https://deb.releases.teleport.dev/teleport-pubkey.asc \
  -o /usr/share/keyrings/teleport-archive-keyring.asc
 
#Add the Teleport APT repository
echo "deb [signed-by=/usr/share/keyrings/teleport-archive-keyring.asc] https://deb.releases.teleport.dev/ stable main" \
| sudo tee /etc/apt/sources.list.d/teleport.list > /dev/null
 
sudo apt-get update
 
sudo apt-get install teleport

teleport configure --acme --acme-email=guntram.klaus@stud.fh-campuswien.ac.at --cluster-name=teleport.nebhis.lcl |    sudo tee /etc/teleport.yaml