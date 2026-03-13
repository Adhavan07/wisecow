resource "tls_private_key" "wisecow_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "wisecow_keypair" {
  key_name   = "wisecow-key"
  public_key = tls_private_key.wisecow_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.wisecow_key.private_key_pem
  filename = "wisecow-key.pem"
}
