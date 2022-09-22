# Value assigned in prod.tfvars
variable "app_name" {
  description = "The name of the App that will be launch"
}
# Value assigned in prod.tfvars
variable "stage" {
  description = "Environment to launch"
}
# Value assigned in prod.tfvars
variable "database_port" {
  type = number
  description = "database port to use"
}

variable "availability_zone_a" {
  type = string
  default = "eu-west-3a"
}

variable "availability_zone_b" {
  type = string
  default = "eu-west-3b"
}
