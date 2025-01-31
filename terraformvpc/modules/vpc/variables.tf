variable "vpc_cidr" {
  description = ""
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = ""
  type = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "subnet_name" {
  description = ""
  type = list(string)
  default = ["Subnet1","Subnet2"]
}