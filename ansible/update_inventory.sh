#!/bin/bash
cd /Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/terraform
public_ip=$(cat terraform.tfstate | jq -r '.resources[] | select(.type=="aws_instance") | .instances[0].attributes.public_ip')
echo "[ec2]" > /Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/ansible/inventory.ini
echo "$public_ip ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa" >> /Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/ansible/inventory.ini
ssh-keyscan -H $public_ip >> ~/.ssh/known_hosts