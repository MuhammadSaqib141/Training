
output "subnets" {
  value = {
    for subnet_key, subnet_value in azurerm_subnet.subnet :
    subnet_key => subnet_value.id
  }
  description = "IDs of the subnets created in the networking module."
}

output "public_ips" {
  value = {
    for public_ip_key, public_ip_value in azurerm_public_ip.public_ip :
    public_ip_key => public_ip_value.id
  }
  description = "IDs of the public IPs created in the networking module."
}
