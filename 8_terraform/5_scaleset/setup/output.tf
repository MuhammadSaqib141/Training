
output "wordpress_subnet_id" {
  description = "The wordpress subnets"
  value = module.networking.wordpress_subnet_id
}

output "db_subnet_id" {
  description = "The databases subnets"
  value = module.networking.db_subnet_id
}
