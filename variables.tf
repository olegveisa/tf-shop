variable "project" {
  type    = string
  default = "tf-shop"
}
variable "region" {
  type    = string
  default = "eu-central-1"
}
variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}
variable "subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}
variable "private_subnet_cidr" {
  type    = string
  default = "10.10.11.0/24"
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "subnets" {
  type = map(object({ cidr_index = number, az = string }))
  default = {
    public-a  = { cidr_index = 1,  az = "a" }
    private-b = { cidr_index = 11, az = "b" }
    private-c = { cidr_index = 12, az = "c" }
    private-d = { cidr_index = 13, az = "c" }
  }
}

variable "env" {
  type    = string
  default = "dev"
}