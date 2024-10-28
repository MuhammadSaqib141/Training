
# output "wordpress_subnet_id" {
#   description = "The wordpress subnets"
#   value = module.networking.wordpress_subnet_id
# }

output "db_subnet_id" {
  description = "The databases subnets"
  value = module.networking.db_subnet_id
}

output "wordpress_subnet_id" {
  description = "The databases subnets"
  value = module.networking.wordpress_subnet_id
}

output "subnets" {
  value = module.networking.subnets
}

output "PublicIPAddressForLB" {
  value = module.networking.PublicIPAddressForLB
}