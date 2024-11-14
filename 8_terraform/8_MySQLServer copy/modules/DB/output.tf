
# output "mysql_server_hostname" {
#   value = { 
#     for server in azurerm_mysql_flexible_server.this : 
#     server.name => server.fqdn 
#   }
# }

output "mysql_server_hostname" {
  value = azurerm_mysql_flexible_server.this.fqdn
}
