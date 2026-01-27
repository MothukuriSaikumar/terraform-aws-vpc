resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "dedicated"
  enable_dns_hostnames = true

  tags = merge (locals.common_tags, 
  {
    
    Name = " locals.comman_name_suffix}-vpc"
  }
  )
}
#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge (locals.common_tags, 
  {
    
    Name = " locals.comman_name_suffix}-igw"
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
  availability_zone = var.availability_zones[count.index]

  tags = merge (locals.common_tags, 
  {
    
    Name = " ${locals.common_name_suffix}-public-subnet-1"
  }
  )
}