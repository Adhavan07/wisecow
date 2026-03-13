resource "aws_instance" "wisecow_server" {

  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.wisecow_subnet.id
  vpc_security_group_ids = [aws_security_group.wisecow_sg.id]

  associate_public_ip_address = true
  key_name = aws_key_pair.wisecow_keypair.key_name

  tags = {
    Name = "wisecow-k3s-server"
  }

}
