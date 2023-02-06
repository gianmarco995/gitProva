#!/bin/bash 
sudo ansible-playbook -i inventory.yml playbook.yml --key-file=/home/ubuntu/pk.pem --vault-password-file ~/.vault_pass.txt
