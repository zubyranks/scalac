variable "profile" {
  type    = string
  default = "CodecommitUser"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "my_ip_address" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}
