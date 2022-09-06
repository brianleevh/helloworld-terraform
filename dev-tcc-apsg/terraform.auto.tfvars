# VPC
vpc_cidr = "10.1.0.0/24"

# Subnet
subnet_pub = [{
  subnet_cidr       = "10.1.0.0/26"
  availability_zone = "ap-singapore-1"
  }, {
  subnet_cidr       = "10.1.0.64/26"
  availability_zone = "ap-singapore-2"
}]
subnet_priv = [{
  subnet_cidr       = "10.1.0.128/26"
  availability_zone = "ap-singapore-1"
  }, {
  subnet_cidr       = "10.1.0.192/26"
  availability_zone = "ap-singapore-2"
}]