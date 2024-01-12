variable "ubuntu_ami_id" {
  type    = string
  default = "ami-0f3a440bbcff3d043"
}

variable "ec2_names" {
  type        = list(string)
  default     = ["Development", "Production"]
  description = "These are ec2 names"
}

variable "vpc_network_cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "This is network cidr"
}

variable "subnet_names" {
  type        = string
  default     = "app"
  description = "This is subnet name"
}

variable "app_ec2_size" {
  type    = string
  default = "t2.micro"
}

variable "private_keypair" {
  type        = string
  description = "this is for ec2 login"
  default     = "~/.ssh/id_rsa"

}
variable "subnet_azs" {
  type        = string
  description = "This is  azs"
  default     = "ap-northeast-2a"
}