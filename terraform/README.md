## Build the infrastructure with Terraform

#### 1. Download and install terraform
- Find the binary suitable for your system [here](https://www.terraform.io/downloads)
- Copy the downloaded binary to your system `PATH` follow the instruction [here](https://learn.hashicorp.com/tutorials/terraform/install-cli)

#### 2. Set up credential for AWS
- In AWS console > IAM Services > Users > Add users
  - Give Permission policies to your user. Bellow are the suggestion but it should never be used in production
    -   AmazonEC2FullAccess
       - AmazonRDSFullAccess
       - AmazonKinesisFirehoseFullAccess
       - IAMFullAccess
       - AmazonVPCFullAccess
       - AmazonS3FullAccess
 
- Save the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to `/.aws/credentials` stored in your local main. It should look like this:
  ```
  [user-name]
  aws_access_key_id=xxxxxxxxxx
  aws_secret_access_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  ```

#### 3. Run Terraform
- To clone the repo:
```
git clone https://github.com/phucnh22/ddc-api-server.git
cd ddc-api-server
```

- Fill in the `prod.tfvars`. Edit the necessary variables to suit with your AWS set up

- Excecute Terraform commands:
  - Execute `terraform init` to initiate the Terraform configuration
  - Execute `terraform plan -var-file=prod.tfvars` to verify changes
  - Execute `terraform apply -var-file=prod.tfvars` to apply to AWS
  - Full code:
```tf
cd terraform
terraform init
terraform apply -var-file=prod.tfvars
```