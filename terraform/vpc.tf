resource "aws_vpc" "wisecow_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "wisecow-vpc"
  }
}

resource "aws_subnet" "wisecow_subnet" {
  vpc_id            = aws_vpc.wisecow_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "wisecow-subnet"
  }
}

