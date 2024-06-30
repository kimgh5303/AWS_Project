# 프라이빗 라우트 테이블 1 정의
resource "aws_route_table" "private-route-table1" {
  vpc_id = aws_vpc.vpc.id

  # 인터넷 트래픽을 NAT 게이트웨이로 라우팅하는 규칙을 설정
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = var.private-rt-name1
    Owner = var.owner-tag
  }
}

# 프라이빗 라우트 테이블 2 정의
resource "aws_route_table" "private-route-table2" {
  vpc_id = aws_vpc.vpc.id


  # 인터넷 트래픽을 NAT 게이트웨이로 라우팅하는 규칙을 설정
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw2.id
  }

  tags = {
    Name = var.private-rt-name2
    Owner = var.owner-tag
  }
}

# web 서브넷 1을 프라이빗 라우트 테이블 1에 연결
resource "aws_route_table_association" "pri-rt-asscociation-1" {
  subnet_id      = aws_subnet.web-subnet1.id
  route_table_id = aws_route_table.private-route-table1.id
}

# web 서브넷 2를 프라이빗 라우트 테이블 2에 연결
resource "aws_route_table_association" "pri-rt-asscociation-2" {
  subnet_id      = aws_subnet.web-subnet2.id
  route_table_id = aws_route_table.private-route-table2.id
}

# app 서브넷 1을 프라이빗 라우트 테이블 1에 연결
resource "aws_route_table_association" "pri-rt-asscociation-3" {
  subnet_id      = aws_subnet.app-subnet1.id
  route_table_id = aws_route_table.private-route-table1.id
}

# app 서브넷 2를 프라이빗 라우트 테이블 2에 연결
resource "aws_route_table_association" "pri-rt-asscociation-4" {
  subnet_id      = aws_subnet.app-subnet2.id
  route_table_id = aws_route_table.private-route-table2.id
}