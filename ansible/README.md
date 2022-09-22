## To run the project:

#### In AWS:
- Create an Elastic IP in AWS > VPC services > Elastic IPs
- Create a SSH key pair in AWS > EC2 services > Key pair -> Save the private key (file_name.pem) in your local machine

#### In your local development machine:

Install Ansibles in ubuntu
```
$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible -y
```

To clone the repo:
```
git clone https://github.com/phucnh22/ddc-api-server.git
```

Copy the SSH key to ansible folder
```
cp /mnt/c/Users/Admin/.ssh/phuc_edu.pem /home/phucnh22/ddc-api-server/ansible/ssh_keys/phuc_edu.pem
```
- After copying, give root access to the key:
```
sudo chmod 600 /home/phucnh22/ddc-api-server/ansible/ssh_keys/phuc_edu.pem
```
#### In `/ansible` folder:
- Fill in the ansible variables found in ansible/group_vars/all
- Write your application ansible role by filling in ansible/roles/application. The current contents are an example of setting up a ghost blog and serving
it behind an nginx reverse proxy
- Fill in any ssh public keys for admins in the ansible/ssh_keys/authorized_keys
- Fill in the ip address of the host (refering to the elastic IP you generated) in the ansible/hosts

#### Workflow
1. Run initial setup
- Running the setup_instance role
```
ansible-playbook -i hosts machine-initial-setup.yml
```
- Running the nginx roles to install nginx and certificate
```
ansible-playbook -i hosts install-nginx-and-certs.yml
```
- Running the application roles to install the application to the webserver
```
ansible-playbook -i hosts install-app.yml
```
- Running the firehose roles to install the firehose agent
```
ansible-playbook -i hosts install-firehose.yml
```
2.

To ssh to the EC2:
`ssh -i "phuc_edu.pem" ubuntu@phucnh22.site`

