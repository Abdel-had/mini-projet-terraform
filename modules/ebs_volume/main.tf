resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = var.ebs_size
}