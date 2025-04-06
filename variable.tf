variable "ec2_instance_type" {
    default = "t2.micro"
    type = string
}

variable " ec2_root_storage_size" {
    default = 10
    type = number
}

variable "my_enviroment" {
  description = "Instance type for the EC2 instance"
  default     = "dev"
}