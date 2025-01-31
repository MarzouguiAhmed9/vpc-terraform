variable "vpc_cidr" {
  description = "cidr for vpc1"
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "cidr for my subnets"
  type = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "subnet_name" {
  description = "names for my subnets"
  type = list(string)
  default = ["Subnet1","Subnet2"]
}