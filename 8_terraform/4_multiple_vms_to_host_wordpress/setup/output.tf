


# output "nsgs_id" {
#   description = "The IDs of the created subnets"
#   value = module.networking.nsg_ids
# }



# output "ids_subnets" {
#   description = "The IDs of the created subnets"
#   value = module.networking.subnet_ids
# }

output "Subnets" {
  description = "The IDs of the created subnets"
  value = module.networking.subnets
}

output "Nsgs" {
  description = "The IDs of the created subnets"
  value = module.networking.nsgs
}