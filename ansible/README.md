## Run the project with Ansible

#### 1. In AWS:
- Create an Elastic IP in AWS > VPC services > Elastic IPs
- Assign the elastic IP generated to your domain zone A
- Create a SSH key pair in AWS > EC2 services > Key pair. Then download and save the private key (RSA format) `file_name.pem` in your local machine (default at: /home/user/.ssh)

#### 2. In your local development machine:

Development Ubuntu version: Ubuntu 18.04

Install Ansibles in ubuntu
```
$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible -y
```

To clone the repo if you haven't:
```
git clone https://github.com/phucnh22/ddc-api-server.git
```

Copy the SSH key to ansible folder. Please make your to not push this key to any public repository
- For Ubuntu
```
cp /.ssh/key_name.pem /home/user/ddc-api-server/ansible/ssh_keys/key_name.pem
```
- For WSL
```
cp /mnt/c/Users/UserName/.ssh/key_name.pem /home/user/ddc-api-server/ansible/ssh_keys/key_name.pem
```
- After copying, give root access to the key:
```
sudo chmod 600 /home/user/ddc-api-server/ansible/ssh_keys/key_name.pem
```

#### 3. Fill in necessary information
- Fill in the ansible variables found in `/group_vars/all` 
- Change the key name and public domain in  `hosts` 
- Fill in any ssh public keys for admins in the `/ssh_keys/authorized_keys`
  - To generate your RSE public key, use this command `ssh-keygen -t rsa -b 4096`, the keys should be located in /.ssh/*.pub

#### 4. Workflow

- Make sure to have the ssh key generated from your AWS account for Ansible to SSH to the EC2 instance
- Running the 4 playbooks for 4 roles
  - Setup_instance role to install required environment
  - Nginx roles to install nginx and SSL certificate (Certbot)
  - Application roles to install the application to the webserver
  - Firehose roles to install the firehose agent to start streaming to S3 bucket
```
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

