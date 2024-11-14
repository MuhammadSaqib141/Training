# # Outputs to access module outputs
# output "subnets" {
#   value = {
#     for key, module_output in module.networking :
#     key => module_output.subnets
#   }
#   description = "Subnets created in the networking module."
# }

# output "public_ips" {
#   value = {
#     for key, module_output in module.networking :
#     key => module_output.public_ips
#   }
#   description = "Public IPs created in the networking module."
# }
