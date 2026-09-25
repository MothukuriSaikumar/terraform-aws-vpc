resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "dedicated"
  enable_dns_hostnames = true

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}"
  }
  )
}
#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-igw"
  }
  )
}
#IGW
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-igw"
  }
  )
}
#public subnet
resource "aws_subnet" "public_subnet_1" {
    count = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = locals.az_names[count.index]

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-public-subnet-1"
  }
  )
}
# private subnet
resource "aws_subnet" "private_subnet_1" {
    count = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = locals.az_names[count.index]

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-private-subnet-1"
  }
  )
}
#database subnet
resource "aws_subnet" "database_subnet" {
    count = length(var.database_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidrs[count.index]
  availability_zone = locals.az_names[count.index]

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-database-subnet"
  }
  )
}

#public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-public-route-table"
  }
  )


}
#private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-private-route-table"
  }
  )
}

#database route table
resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.main.id

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-database-route-table"
  }
  )
}

#public route 
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
#Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = true

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-nat"
  }
  )
}
#nat gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1[0].id

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-nat-gateway"
  }
  )
  depends_on = [aws_internet_gateway.igw]
}
#private egress route to NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
resource "aws_route" "database_route" {
  route_table_id         = aws_route_table.database_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
#public route table association
resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnet_1[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
#private route table association
resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnet_1[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
#database route table association
resource "aws_route_table_association" "database_route_table_association" {
  count          = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database_subnet.id
  route_table_id = aws_route_table.database_route_table.id
}

