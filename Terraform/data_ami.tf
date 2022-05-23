data "aws_ami" "latest" {
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

output "Latest_ubuntu" {
    value = data.aws_ami.latest.id
  
}