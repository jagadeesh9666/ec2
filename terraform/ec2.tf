resource "aws_key_pair" "private" {
  key_name   = "Powershell"
  public_key = file(var.public_keypair)
  tags = {
    createdby = "jagadeesh"
  }
}

resource "aws_instance" "tire" {
  ami                         = var.ubuntu_ami_id
  count = length(var.ec2_names)
  associate_public_ip_address = true
  instance_type               = var.app_ec2_size
  key_name                    = aws_key_pair.private.key_name
  vpc_security_group_ids      = [aws_security_group.app.id]
  subnet_id                   = aws_subnet.app.id

  tags = {
    Name = var.ec2_names[count.index]
  }
  depends_on = [aws_subnet.app]
}
