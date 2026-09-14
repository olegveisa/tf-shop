variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "subnets" {
  type = map(object({
    cidr_index = number
    az         = string
  }))
}