resource "aws_vpc" "RDS-vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "RDS-subnet-public-1" {
    
    vpc_id = aws_vpc.RDS-vpc.id
    
    cidr_block = var.subnet1
    
    availability_zone = var.availability-zone1
    
}

resource "aws_subnet" "RDS-subnet-public-2" {

    vpc_id = aws_vpc.RDS-vpc.id

    cidr_block = var.subnet2

    availability_zone = var.availability-zone2

}


resource "aws_internet_gateway" "RDS-igw" {
    vpc_id = aws_vpc.RDS-vpc.id
}


resource "aws_route_table" "RDS-public-crt" {
    vpc_id = aws_vpc.RDS-vpc.id
    
    route {
        //associated subnet can reach everywhere
      
        cidr_block = var.cidr_block2
        
        //CRT uses this IGW to reach internet
        
        gateway_id = aws_internet_gateway.RDS-igw.id
    }
    
}


resource "aws_route_table_association" "RDS-crta-public-subnet-1"{
    
    subnet_id = aws_subnet.RDS-subnet-public-1.id
    route_table_id = aws_route_table.RDS-public-crt.id
}
