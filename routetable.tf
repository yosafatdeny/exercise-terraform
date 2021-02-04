resource "aws_route_table" "route-tv-public" {
  vpc_id = aws_vpc.exec-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tv-igw.id
  }

  tags = {
    Name = "route-tv-public"
  }
}


resource "aws_route_table_association" "rt-public1" {
  subnet_id      = aws_subnet.tv-public-1.id
  route_table_id = aws_route_table.route-tv-public.id
}

resource "aws_route_table_association" "rt-public2" {
  subnet_id      = aws_subnet.tv-public-2.id
  route_table_id = aws_route_table.route-tv-public.id
}

resource "aws_route_table_association" "rt-public3" {
  subnet_id      = aws_subnet.tv-public-3.id
  route_table_id = aws_route_table.route-tv-public.id
}