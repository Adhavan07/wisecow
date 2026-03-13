resource "aws_internet_gateway" "wisecow_igw" {
  vpc_id = aws_vpc.wisecow_vpc.id

  tags = {
    Name = "wisecow-igw"
  }
}

resource "aws_route_table" "wisecow_rt" {
  vpc_id = aws_vpc.wisecow_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wisecow_igw.id
  }
}

resource "aws_route_table_association" "wisecow_rta" {
  subnet_id      = aws_subnet.wisecow_subnet.id
  route_table_id = aws_route_table.wisecow_rt.id
}
