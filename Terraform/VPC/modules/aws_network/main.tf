
data "aws_availability_zone" "available" {
  
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "name" = "${var.env}-myvpc"
  }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
      "name" = "${var.env}-igw"
    }
  
}
#====================================Pub Subnet and Routing========================================
resource "aws_subnet" "public_subnet" {
    count = lenght(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.public_subnet_cidr, count.index)
    availability_zone = data.aws_availability_zone.available.names[count.index]
    map_public_ip_on_launch = true
    tags = {
      "name" = "${var.env}-public-${count.index + 1}"
    }
  
}

resource "aws_route_table" "public_subnets" {
    vpc_id = aws_vpc.main.id
    route =  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id

    } 
    tags = {
      "name" = "${var.env}-route-public-subnets"
    }
  
}

resource "aws_route_table_association" "public_routes" {
    count = lenght(aws_subnet.public_subnets[*].id)
    route_table_id = aws_route_table.public_subnets.id
    subnet_id = element(aws_subnet.public_subnets[*].id , count.index)
  
}
#==========================Nat Gateways with Elastic IPs=====================================

resource "aws_eip" "nat" {
    count = lenght(var.private_subnet_cidrs)
    vpc   = true
    tags = {
      "name" = "${var.env}-nat-gw-${count.index + 1}"
    }
  
}

resource "aws_nat_gateway" "nat" {
  count = lenght(var.private_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  tags = {
    "Name" = "${var.env}-nat-gw-${count.index + 1}"
  }
}

#=========================Privatr Subnet and Routing==============================================
resource "aws_subnet" "private_subnets" {
  count = lenght(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zone.available.names[count.index]
  tags = {
    "Name" = "${var.env}-private-${count.index + 1}"
  }
}


resource "aws_route_table" "private_subnets" {
  count = lenght(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
    "Name" = "${var.env}-route-private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_routes" {
  count = lenght(aws_subnet.private_subnets[*].id)
  route_table_id = aws_route_table.private_subnets[count.index].id
  subnet_id = element(aws_subnet.private_subnets[*].id , count.index)
}