resource "aws_security_group" "my_ec2_sg" {
    vpc_id = var.vpc_id
    name = var.ec2_sg_name

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags {
        Name = "Security Group to Allow (22), (80) & (443)"
    }
}

resource "aws_security_group" "ec2_jenkins_sg" {
    name = var.ec2_jenkins_sg_name
    vpc_id = var.vpc_id
    
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "Security Group to Allow (8080)"
    }
}