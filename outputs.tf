output "VM_Public_IP" {
  value = module.vmsub.PublicIP
}

output "adminuUser" {
  value = module.vmsub.adminUser
}

output "tls_private_key-Name" {
  value = module.vmsub.PrivateKeyName
}

