
#Variables Required <br>
#--------------------- <br>
 # variable usage  (these variables need to be defined in terraform.tfvars or in azure-cloud) <br>
 resgrp         = var.resgrp   # resource group name <br>
 region         = var.region <br>
 resgrptag      = var.resgrptag <br>
 vnet           = var.vnet <br>
 cidr           = var.cidr # ["10.0.1.0/16"] <br>
 subnetname     = var.subnetname <br>
 subnet         = var.subnet # ["10.0.1.0/24"] <br>
 publicip       = var.publicip <br>
 sgname         = var.sgname <br>
 netIntName     = var.netIntName <br>
 ipName         = var.ipName <br>
 vmName         = var.vmName <br>
 osDiskName     = var.osDiskName <br>
 imagePublisher = var.imagePublisher # "Canonical" <br>
 image          = var.image          # "UbuntuServer" <br>
 imageSku       = var.imageSku       # "18.04-LTS" <br>
 adminUser      = var.adminUser      # "azureuser" <br>
 privKey        = var.privKey  <br>


#  Environment Variables Required Depends on if you are using PFX Certificates or if you are using Client Secrets for AZ Service Principal

# The below envorionment variables need to be defined in Terraform Cloud if running this from Terraform Cloud.  If running locally, define them as local env variables.  This is the case if you are using PFX certificates for AZ Service Principal
export ARM_CLIENT_ID="" <br>
export ARM_CLIENT_CERTIFICATE_PATH=""    # this needs to point to wherever you have the pfx certificate stored in your local machine.  e.g. export ARM_CLIENT_CERTIFICATE_PATH="/home/aciadmin/Terraform/certs/temp/service-principal.pfx" <br>
export ARM_CLIENT_CERTIFICATE_PASSWORD=""  # this needs to match the password that you entered while creating the PFX certificate.  Please see How to below.  (step 3 on PFX cert creation) <br>
export ARM_SUBSCRIPTION_ID="" <br>
export ARM_TENANT_ID="" #  this is the Directory / Tenant ID <br>

# OR


# The Below environment variables need to be defined in Terraform Cloud if running this from Terraform Cloud.  If running locally,define as local env variables.  This is the case if you are using client certificates for AZ Service Principal
export ARM_CLIENT_ID="" <br>
export ARM_CLIENT_SECRET="" <br>
export ARM_TENANT_ID="" <br>
export ARM_SUBSCRIPTION_ID="" <br>


#  How to create PFX certificate or how to create client certificate in Azure for Service Principal

#Required for Terraform if using PFX certificates: <br>
#--------------------------------------------------------------- <br>
	1) create key and generate a certificate signing request (CSR) using that key
openssl req -newkey rsa:4096 -nodes -subj '/CN=sp/O=sp.com/C=US' -keyout "service-principal.key" -out "service-principal.csr"

Sign the CSR using the key and generate a Certificate (CRT)
	2) openssl x509 -signkey "service-principal.key" -in "service-principal.csr" -req -days 365 -out "service-principal.crt"


	3) Finally we can generate a PFX file which can be used to authenticate with Azure:
openssl pkcs12 -export -out "service-principal.pfx" -inkey "service-principal.key" -in "service-principal.crt"

At this time it will ask for a password:
aciadmin@ubuntu-jump:~/Terraform/ACI/cAPIC-AZ-AKS/certs/temp$ openssl pkcs12 -export -out "service-principal.pfx" -inkey "service-principal.key" -in "service-principal.crt"
Enter Export Password:
                 for example: Password123

	4) Now on AZ console go to Active Directory/App Registeration/New Registeration
Put in some name:  Terraform1  # Terraform1 is just an example, choose whatever you want it to be <br>
Who can use:  Choose Single Tenant <br>
Redirect URI:  Keep to WEB <br>

hit Register <br>

Now you will see the following: <br>
Application Client ID: blah <br>
Directory: blah <br>
Object ID: blah <br>


	5) Now go to certificates & secrets and upload the public certificate: service-principal.crt and add that.

	6) Now go to subscription/IAM and add Role for Terraform1 to be contributer ( you will have to type in "Terraform1" in the Select field for it to show up.


#Required for Terraform if using Client Secrets: <br>
#---------------------------------------------------------------- <br>
	1) az login -u azusername@domain -p blah  (or just az login)
	2) az account set d481e123-9363-4712-ab98-c00d9675c071
	3) az ad sp create-for-rbac --name cloudAciBootcamp --role=Contributor
	
	{
	  "appId": "blah",
	  "displayName":"blah",
	  "name": "blah",
	  "password": "blah",
	  "tenant": "blah"
	}

