# ddc-api-server
### Tech stack including `terraform-ansible-fastapi-nginx-gunicorn-letsencrypt-firehose-S3`
---
This repository is used to build a web-app running with **Nginx / Gunicorn / FastAPI / LetsEncrypt (Certbot)**. The fastapi server will stream the logs from https post request to an **S3 Bucket** via an **AWS Kinesis Firehose** delivery stream.

The whole application can be deployed effortlessly with **Terraform** and **Ansible**

--- 
## Prerequisites
To be able to run the complete application, you would need several applications ready in your machine
1. [Terraform](https://www.terraform.io/) installed. Details of usage are described [here](https://github.com/phucnh22/ddc-api-server/tree/main/terraform) 
2. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed. Details of usage are described [here](https://github.com/phucnh22/ddc-api-server/tree/main/terraform) 
3. An AWS account
---  
## Setting up the application
#### 1. Clone this repo on your server
```sh
sudo git clone https://github.com/phucnh22/ddc-api-server.git
```
#### 2. Set up infrastructure with Terraform

- Make sure the **credential and keys** required for terraform to run in your AWS account is available at `/.aws/credentials`. Please see details [here](https://github.com/phucnh22/ddc-api-server/tree/main/terraform) 
- Fill in the `prod.tfvars`. Edit the necessary variables to suit with your AWS set up
- Execute `terraform init`
- Execute `terraform plan -var-file=prod.tfvars` to verify changes
- Execute `terraform apply -var-file=prod.tfvars` to apply to AWS
- Full code:
```tf
cd terraform
terraform init
terraform apply -var-file=prod.tfvars
```

#### 3. Deploy the application with Ansible
- Make sure to have the ssh key generated from your AWS account for Ansible to SSH to the EC2 instance
- Fill in all the required fields described [here](https://github.com/phucnh22/ddc-api-server/tree/main/ansible)
- Running the 4 playbooks for 4 roles
  - Setup_instance role to install required environment
  - Nginx roles to install nginx and SSL certificate (Certbot)
  - Application roles to install the application to the webserver
  - Firehose roles to install the firehose agent to start streaming to S3 bucket
```
cd ansible
ansible-playbook -i hosts machine-initial-setup.yml
ansible-playbook -i hosts install-nginx-and-certs.yml
ansible-playbook -i hosts install-app.yml
ansible-playbook -i hosts install-firehose.yml
```
- Verified all the service is running by SSH to the server
```sh
ssh -i "/.ssh/<your-AWS-key>.pem" ubuntu@<your-domain>
```
- Verify the status of the service
```
sudo service aws-kinesis-agent status
sudo service ddc-api-server status
```
- Your web server should be available at `https://your-domain/docs`

<p style="text-align: center;">
 🎉 Your web-app is now running online at your domain with HTTPS 🎉   
</p>

---  
## Annex
#### To build your application in local machine with AWS console (click-click-click), please see [note](https://github.com/phucnh22/ddc-api-server/blob/main/local-setup-note.md)
  