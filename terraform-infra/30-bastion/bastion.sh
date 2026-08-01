#!/bin/bash

# We are creating 50GB root disk, but only 20GB is partitioned
# Remaining 30GB we need to extend using below commands
growpart /dev/nvme0n1 4
lvextend -r -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

# 4. Install Yum utilities
yum install -y yum-utils

# 5. Connect official HashiCorp release stream
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

# 6. Install the Terraform binary 
yum install -y terraform