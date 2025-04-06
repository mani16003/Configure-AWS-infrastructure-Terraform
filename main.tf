resource aws_key_pair my_key {
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
}

#VPC

resource aws_default_vpc default {

}

# security group

resource aws_security_group my_security_group{
    name = "automate-sg"
    description = "Tf generated security group"
    vpc_id = aws_default_vpc.default.id 

#inbound rule

ingress {
    from_port = 22
    to_port  = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port = 80
    to_port  = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

#outbound rule

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

# EC2

resource "aws_instance" "my_instance" {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = "t2-micro"
    ami = "ami-084568db4383264d4"

user_data = file("install_nginx.sh")

    root_block_device {
        volume_size = 10
        volume_type = "gp3"
    }

    tags = {
        Name = "Terraform-devops"
    }


    }
