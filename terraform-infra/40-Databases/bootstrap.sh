#!/bin/bash

component=$1

dnf install -y ansible python3-pip git
python3 -m pip install boto3 botocore PyMySQL

cd /home/ec2-user || exit 1

if [ ! -d ansible-roboshop-roles-tf ]; then
  git clone https://github.com/NagaAjay1812/ansible-roboshop-roles-tf.git
fi

cd ansible-roboshop-roles-tf || exit 1

ansible-playbook -e "component=${component}" roboshop.yaml