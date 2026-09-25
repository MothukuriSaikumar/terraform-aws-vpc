variable "cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    
  
}
variable "project_name" {
    description = "The name of the project"
    type        = string
  
}
variable "environment" {
    description = "The environment for the VPC" # dev, prod, staging
    type        = string
  
}
variable "tags" {
    description = "A map of tags to add to all resources"
    type        = map(string)
  
}
variable "igw_tags" {
    description = "A map of tags to add to the internet gateway"
    type        = map(string)
  
}
  
variable "public_subnet_cidrs" {
    description = "A list of CIDR blocks for the public subnets"
    type        = list(string)
  
}
variable "public_subnet_tags" {
    description = "A map of tags to add to the public subnets"
    type        = map(string)
  
}
variable "private_subnet_cidrs" {
    description = "A list of CIDR blocks for the private subnets"
    type        = list(string)
  
}
variable "private_subnet_tags" {
    description = "A map of tags to add to the private subnets"
    type        = map(string)


  
}
variable "database_subnet_cidrs" {
    description = "A list of CIDR blocks for the database subnets"
    type        = list(string)
  
}

variable "database_subnet_tags" {
    description = "A map of tags to add to the database subnets"
    type        = map(string)
  
}
variable "public_route_table_tags" {
    description = "A map of tags to add to the public route table"
    type        = map(string)
  
}
variable "private_route_table_tags" {
    description = "A map of tags to add to the private route table"
    type        = map(string)
  
}
variable "database_route_table_tags" {
    description = "A map of tags to add to the database route table"
    type        = map(string)
  
}
variable "eip_tags" {
    description = "A map of tags to add to the EIP"
    type        = map(string)
  
}
variable "nat_gateway_tags" {
    description = "A map of tags to add to the NAT gateway"
    type        = map(string)
  
}



  
variable "availability_zones" {
    description = "A list of availability zones to use for the subnets"
    type        = list(string)
  
}
variable " is peering_enabled" {
    description = "A boolean to enable or disable VPC peering"
    type        = bool
    default     = false
  
}




