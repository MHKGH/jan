pipeline {
    agent any
    triggers {
        githubPush()
    }

environment {
    PATH = "/opt/homebrew/bin:$PATH"
    SSH_DIR = "/Users/hemanthkumarmotukuri/.ssh"
    TERRAFORM_DIR = "/Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/terraform"
    ANSIBLE_DIR = "/Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/ansible"
}

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        
        stage('Terraform Init') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Executing bash script') {
            steps {
                    sh '''#!/bin/bash
                    cd /Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/terraform
                    public_ip=$(cat terraform.tfstate | jq -r \'.resources[] | select(.type=="aws_instance") | .instances[0].attributes.public_ip\')
                    echo "[ec2]" > /Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/ansible/inventory.ini
                    echo "$public_ip ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa" >> /Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/ansible/inventory.ini
                    echo "$public_ip" > /Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/ansible/Host_IP.txt'''
                }
            }
        
        stage('Executing Local Bash Script') {
            steps {
                sh '/Users/hemanthkumarmotukuri/Documents/DevOps/Practice/my_self_practic/nallagandla/ansible/known_hosts.sh'
            }
            
        }

        stage('Run Ansible Playbook') {
            steps {
                dir("${env.ANSIBLE_DIR}") {
                    sh 'ansible-playbook -i inventory.ini install.yml'
                }
            }
        }
    }
}
