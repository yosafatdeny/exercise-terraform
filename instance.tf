resource "aws_key_pair" "exec-key" {
  key_name = "exec-key" 
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "web" {
  ami                     = var.AWS_AMIS[var.AWS_REGION]
  instance_type           = var.AWS_INSTANCE_TYPE
  subnet_id               = aws_subnet.tv-public-1.id
  vpc_security_group_ids  = [aws_security_group.tf-allow-http.id, aws_security_group.tf-allow-ssh.id]
  key_name                = aws_key_pair.exec-key.key_name
  user_data               = <<-EOF
                      #! /bin/bash
                      sudo apt update
                      sudo apt install apache2 -y
                      sudo systemctl start apache2
                      sudo systemctl enable apache2
                      sudo rm -rf /var/www/html/*
                      echo "================================= CLONE TEMPLATE FROM GITHUB ============================="
                      sudo git clone https://github.com/hisbu/template2.git /var/www/html/
                      echo "================================= add hostname ============================="
                      sudo sed -i -e '1 i\<center>'$(hostname -f)'</center>' /var/www/html/index.html
                    EOF 
  tags = {
    Name = "HelloTerraform"
  }
}


resource "aws_instance" "web2" {
  ami                     = var.AWS_AMIS[var.AWS_REGION]
  instance_type           = var.AWS_INSTANCE_TYPE
  subnet_id               = aws_subnet.tv-public-1.id
  vpc_security_group_ids  = [aws_security_group.tf-allow-http.id, aws_security_group.tf-allow-ssh.id]
  key_name                = aws_key_pair.exec-key.key_name
  user_data               = <<-EOF
                      #! /bin/bash
                      sudo apt update
                      sudo apt install apache2 -y
                      sudo systemctl start apache2
                      sudo systemctl enable apache2
                      sudo rm -rf /var/www/html/*
                      echo "================================= CLONE TEMPLATE FROM GITHUB ============================="
                      sudo git clone https://github.com/hisbu/template2.git /var/www/html/
                      echo "================================= add hostname ============================="
                      sudo sed -i -e '1 i\<center>'$(hostname -f)'</center>' /var/www/html/index.html
                    EOF 
  tags = {
    Name = "HelloTerraform2"
  }
}

resource "aws_instance" "web3" {
  ami                     = var.AWS_AMIS[var.AWS_REGION]
  instance_type           = var.AWS_INSTANCE_TYPE
  subnet_id               = aws_subnet.tv-public-2.id
  vpc_security_group_ids  = [aws_security_group.tf-allow-http.id, aws_security_group.tf-allow-ssh.id]
  key_name                = aws_key_pair.exec-key.key_name
  user_data               = <<-EOF
                      #! /bin/bash
                      sudo apt update
                      sudo apt install apache2 -y
                      sudo systemctl start apache2
                      sudo systemctl enable apache2
                      sudo rm -rf /var/www/html/*
                      echo "================================= CLONE TEMPLATE FROM GITHUB ============================="
                      sudo git clone https://github.com/hisbu/template2.git /var/www/html/
                      echo "================================= add hostname ============================="
                      sudo sed -i -e '1 i\<center>'$(hostname -f)'</center>' /var/www/html/index.html
                    EOF 
  tags = {
    Name = "HelloTerraform3"
  }
}