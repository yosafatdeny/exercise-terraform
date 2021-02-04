variable "AWS_REGION" {
  type = string
  description = "region for aws resource"
  default = "ap-southeast-1"
}

variable "AWS_AMIS" {
  type = map(string)
  description = "map of aws amis id"
  default = {
    ap-southeast-1 = "ami-0c20b8b385217763f"
  }
}

variable "AWS_INSTANCE_TYPE" {
  type = string
  description = "type of aws ec2 instance"
  default = "t2.micro"
}

variable "AWS_KEY_PAIR" {
  type = string
  description = "key pair aws"
  default = "jcde-key" 
}

variable "AWS_SG" {
  type = list
  description = "sg for aws"
  default = ["sg_vm_ssh","sg_vm_http"]
}

variable "PATH_TO_PRIVATE_KEY"{
  type = string
  default = "exec-key"
}

variable "PATH_TO_PUBLIC_KEY"{
  type = string
  default = "exec-key.pub"
}

variable "AWS_INSTANCE_USERNAME" {
  type = string
  default = "ubuntu"
}

