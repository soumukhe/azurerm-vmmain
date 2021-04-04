module "vmsub" {
  source  = "soumukhe/vmsub/azurerm"
  version = "1.0.5"



  # variable usage  (these variables need to be defined in terraform.tfvars or in azure-cloud)
  resgrp         = var.resgrp # resource group name
  region         = var.region
  resgrptag      = var.resgrptag
  vnet           = var.vnet
  cidr           = var.cidr # ["10.0.1.0/16"]
  subnetname     = var.subnetname
  subnet         = var.subnet # ["10.0.1.0/24"]
  publicip       = var.publicip
  sgname         = var.sgname
  netIntName     = var.netIntName
  ipName         = var.ipName
  vmName         = var.vmName
  osDiskName     = var.osDiskName
  imagePublisher = var.imagePublisher # "Canonical"
  image          = var.image          # "UbuntuServer"
  imageSku       = var.imageSku       # "18.04-LTS"
  adminUser      = var.adminUser      # "azureuser"
  privKey        = var.privKey

}
