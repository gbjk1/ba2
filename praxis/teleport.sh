#!/bin/bash

#Download Teleport's PGP public key
curl https://deb.releases.teleport.dev/teleport-pubkey.asc \
  -o /usr/share/keyrings/teleport-archive-keyring.asc
 
#Add the Teleport APT repository
echo "deb [signed-by=/usr/share/keyrings/teleport-archive-keyring.asc] https://deb.releases.teleport.dev/ stable main" \
| tee /etc/apt/sources.list.d/teleport.list > /dev/null
 
apt-get update
apt-get install teleport

#generate cert for https GUI access
openssl genpkey -algorithm RSA -out teleportkey.pem
openssl req -new -key teleportkey.pem -out teleportcsr.pem
openssl x509 -req -days 365 -in teleportcsr.pem -signkey teleportkey.pem -out teleportcert.pem
cp teleportkey.pem /var/lib/teleport/privkey.pem
cp teleportcert.pem /var/lib/teleport/fullchain.pem

#configure teleport
teleport configure --acme --acme-email=guntram.klaus@stud.fh-campuswien.ac.at --cluster-name=teleport.nebhis.lcl \
  --cert-file=/var/lib/teleport/fullchain.pem --key-file=/var/lib/teleport/privkey.pem | tee /etc/teleport.yaml

#run teleport
systemctl enable teleport
systemctl start teleport