output "VM_Public_IP" {
  value = module.azvm.PublicIP
}

output "adminuUser" {
  value = module.azvm.adminUser
}

output "tls_private_key-Name" {
  value = module.azvm.PrivateKeyName
}

