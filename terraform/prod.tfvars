# Simple name with only alpha characters
app_name = "flaskapp"
# you should have manually created this key during the setup
ssh_key_name = "phuc_edu"
# these stages can be anything you'd like though prod / dev / staging are common
stage = "dev"
# usually does not need to be a a big instance - you'd be suprised with what you
# can do with a small instance
instance_type = "t2.micro"
# the elastic ip address allocation id that you manually created in the AWS console
http_server_elastic_ip_allocation_id = "eipalloc-0f6af58c46f0731c6"
# again, you'd be suprised what you can do with a small server
rds_instance_type = "db.t3.micro"

database_user = "app_db_user"
# since the database should only be available from within
# the vpc and definitely NOT be public, a strong password is probably
# not necessary
database_password = "strongpassword123"
# Be sure to use the default port for the type of database you're using
# for postgres: 5432 and mysql: 3306
database_port = 5432

# credentials path stored in local machine_typ
credentials_path = "~/.aws/credentials"
