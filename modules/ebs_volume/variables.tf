variable "ebs_size" {
  type        = number
  default     = 20
}

variable aws_common_tag {
  type        = map
  description = "Set aws tag"
  default = {
    Name = "ec2-abdelhad"
  }
}