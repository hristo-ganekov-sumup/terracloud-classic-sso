variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "role_arn" {
  type    = string
  default = "arn:aws:iam::861104244336:role/x-account-admin"
}


### AWS credential variables provided by ENV
variable "aws_access_key_id" {
  type = string
  default = null
}

variable "aws_secret_access_key" {
  type = string
  default = null
}

### Azure credential variables provided by ENV
variable "client_id" {
  type = string
  default = null
}

variable "client_secret" {
  type = string
  default = null
}

variable "tenant_id" {
  type = string
  default = null
}
