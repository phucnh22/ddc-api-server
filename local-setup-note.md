# Local machine set up with AWS consle
Requirements:
- Your operating system must be Amazon Linux, or Red Hat Enterprise Linux version 7 or later.
- Agent version 2.0.0 or later runs using JRE version 1.8 or later. Agent version 1.1.x runs using JRE 1.7 or later.
- If you are using Amazon EC2 to run your agent, launch your EC2 instance.
- The IAM role or AWS credentials that you specify must have permission to perform the Kinesis Data Firehose PutRecordBatch operation for the agent to send data to your delivery stream.

Process for local deployment with AWS console:
- Create a S3 bucket
- Create a Kinesis Data Firehose
  - source: Direct PUT
  - destination: S3 bucket URI
  - data transformation: Disabled
  - Record format conversion: Disabled
  - Skip Advanced settings and click Create delivery stream.
- Spin up an AWS Linux 2 instance
  - Amazon Linux 2 AMI
  - instance type: t2.micro
  - name: Kinesis-Agent
- Create IAM Role
  - Create IAM role for kinesis policies
  - Attach IAM role to EC2 instance to perform services
  
- SSH to the instance
  - `ssh -i "phuc_edu.pem" ubuntu@ec2-13-37-103-197.eu-west-3.compute.amazonaws.com`
  - `cd /opt`
  - `sudo git clone https://github.com/awslabs/amazon-kinesis-agent.git`
  - Edit/Verify config in agent.json at `/etc/aws-kinesis/agent.json`
  - `sudo chown aws-kinesis-agent-user:aws-kinesis-agent-user -R /home/ubuntu/ddc-api-server` : give permission to the agent
  - Start agent `sudo service aws-kinesis-agent start`
  - Agent status: `sudo service aws-kinesis-agent status`
  - Check log: `sudo tail -f /var/log/aws-kinesis-agent/aws-kinesis-agent.log`