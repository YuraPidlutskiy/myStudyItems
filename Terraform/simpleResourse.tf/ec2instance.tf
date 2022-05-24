provider "aws" {
    region = "eu-west-1"
}

resource "aws_eip" "statick_ip" {
  instance = aws_instance.linux_Ubuntu.id # for attach statick ip to instance
}

resource "aws_instance" "linux_Ubuntu" {
    count = 3
    ami = "ami-09ce2fc392a4c0fbc"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.web_server.id]
    user_data = file("init.sh")
    # user_data = templetfile("initTPL.sh.tpl", {
    #  myName = "yura"
    # theirName = ["vasyl","ivan","misha","yaroslav"]  
    # })
   
   lifecycle {
     create_before_destroy = true # for create new ins and after delet old 
   }

  tags = {
    "name" = "XtTest"
  }
  depends_on = [
    aws_instance.linux_Database
  ]
}

resource "aws_instance" "linux_Database" {
    count = 3
    ami = "ami-09ce2fc392a4c0fbc"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.web_server.id]
    user_data = file("db_init.sh")
    
   
 

  tags = {
    "name" = "DBtest"
  }
}