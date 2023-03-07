# Create key pair for SSH access
resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Create EC2 instances
resource "aws_instance" "bastion" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.small"
  key_name      = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id     = aws_subnet.public1.id
  associate_public_ip_address = true
  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.small"
  key_name      = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.private_instances_sg.id]
  subnet_id     = aws_subnet.private1.id
  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "app" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.small"
  key_name      = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.private_instances_sg.id]
  subnet_id     = aws_subnet.private2.id
  tags = {
    Name = "app"
  }
}
