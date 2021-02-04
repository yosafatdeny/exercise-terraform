resource "aws_subnet" "tv-public-1" {
  vpc_id     = aws_vpc.exec-vpc.id
  cidr_block = "21.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tv-public-1"
  }
}

resource "aws_subnet" "tv-public-2" {
  vpc_id     = aws_vpc.exec-vpc.id
  cidr_block = "21.0.2.0/24"
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tv-public-2"
  }
}

resource "aws_subnet" "tv-public-3" {
  vpc_id     = aws_vpc.exec-vpc.id
  cidr_block = "21.0.3.0/24"
  availability_zone = "ap-southeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "tv-public-3"
  }
}