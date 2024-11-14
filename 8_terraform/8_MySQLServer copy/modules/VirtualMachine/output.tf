# ../modules/VirtualMachine/outputs.tf

output "vm_id" {
  description = "The ID of the created Linux virtual machine"
  value       = azurerm_linux_virtual_machine.linux_vm.id
}

output "nic_id" {
  description = "The ID of the created network interface"
  value       = azurerm_network_interface.linuxvm_nic.id
}

