#creating vpc

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true


  tags = local.vpc_final_tags
}

# creating IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id # Directly references the VPC resource above

  tags = {
    Name = var.project
  }
}

# creating subnets for public, private, database
#public
resource "aws_subnet" "public" {
  count = length(var.public_cidr_blocks)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr_blocks[count.index]
  availability_zone       = var.pub_avai_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-public-${var.pub_avai_zones[count.index]}" #roboshop-public-us-east-1a/1b
  }
}

#private
resource "aws_subnet" "private" {
  count = length(var.private_cidr_blocks)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr_blocks[count.index]
  availability_zone = var.private_avai_zones[count.index]

  # Private subnets should not assign public IPs on launch
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-private-${var.private_avai_zones[count.index]}"
  }
}


#database
resource "aws_subnet" "database" {
  count = length(var.database_cidr_blocks)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_cidr_blocks[count.index]
  availability_zone = var.database_avai_zones[count.index]

  # Database subnets are strictly isolated and do not assign public IPs
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-database-${var.database_avai_zones[count.index]}"
  }
}


# --- PUBLIC ROUTE TABLE ---
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  # Send all non-local traffic (0.0.0.0/0) directly to your Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-public" # roboshop-public
  }
}

# --- PRIVATE ROUTE TABLE ---
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-private" # roboshop-private
  }
}

# --- DATABASE ROUTE TABLE ---
resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-database" # roboshop-database
  }
}

# Associate both public subnets to the public route table
resource "aws_route_table_association" "public" {
  count          = length(var.public_cidr_blocks)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Associate both private subnets to the private route table
resource "aws_route_table_association" "private" {
  count          = length(var.private_cidr_blocks)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

# Associate both database subnets to the database route table
resource "aws_route_table_association" "database" {
  count          = length(var.database_cidr_blocks)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database_rt.id
}

#  Allocate a Static Public IP Address for the NAT Gateway
resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-nat-eip"
  }
}

#  Create the NAT Gateway in the public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id # only one subnet
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-NAT" # roboshop-dev-NAT
    }

  )
}


# --- PRIVATE ROUTE (Attaches NAT Gateway to Private Route Table) ---
resource "aws_route" "private_internet_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# --- DATABASE ROUTE (Attaches NAT Gateway to Database Route Table) ---
resource "aws_route" "database_internet_route" {
  route_table_id         = aws_route_table.database_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}


