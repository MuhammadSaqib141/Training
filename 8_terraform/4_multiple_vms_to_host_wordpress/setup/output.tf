


output "wordpress_subnet_id" {
  description = "The IDs of the created subnets"
  value = module.networking.wordpress_subnet_id
}

output "wordpress_nsg_id" {
  description = "The IDs of the created subnets"
  value = module.networking.wordpress_nsg_id
}

output "db_subnet_id" {
  description = "The IDs of the created subnets"
  value = module.networking.db_subnet_id
}

output "db_nsg_id" {
  description = "The IDs of the created subnets"
  value = module.networking.db_nsg_id
}