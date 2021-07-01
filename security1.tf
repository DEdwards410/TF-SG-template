
locals {
  common_tags = {
    Name                    = "KING_DON"
    App_Name                = "ovid"
    Cost_center             = "xyz222"
    Business_unit           = "GBS"
    Business_unit           = "GBS"
    App_role                = "web server"
    App_role                = "web server"
    Environment             = "dev"
    Security_Classification = "NA"
  }
}

locals {
  ingress_rules = [{
    port        = 443
    description = "https port"
    },
    {
      port        = 8000
      description = "http proxy port"
    },
    {
      port        = 53
      description = "DNS port"
    },
    {
      port        = 80
      description = "http port"
    },
    {
      port        = 3389
      description = "rdp port"
    },
    {
      port        = 22
      description = "ssh port"
    },
    {
      port        = 23
      description = "telnet"
    },
    {
      port        = 123
      description = "NTP port"
    },
    {
      port        = 2049
      description = "NFS"
    },
    {
      port        = 1241
      description = "Nessus"
  }]
}



resource "aws_vpc" "TobagoVPC" {
  cidr_block = "10.0.160.0/22"
}

resource "aws_eip" "lb" {
  vpc = "true"

}

output "eip" {
  value = aws_eip.lb.public_ip
}

output "eip1" {
  value = aws_eip.lb.id
}

resource "aws_security_group" "Nessus_Scanner" {
  name        = "Nessus_Scanner"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.TobagoVPC.id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
    }
  }
  tags = local.common_tags
}

  /*ingress {
    description      = "https port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "http proxy port"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "dns port"
    from_port        = 53
    to_port          = 53
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "http port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "rdp port"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "ssh port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "telnet port"
    from_port        = 23
    to_port          = 23
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "smtp port"
    from_port        = 25
    to_port          = 25
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "NTP port"
    from_port        = 123
    to_port          = 123
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "NFS port"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "Nessus port"
    from_port        = 1241
    to_port          = 1241
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  #  cidr_blocks      = [aws_eip.lb.public_ip/32]
  }
*/
