variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "devops-assignment-rg"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "devops-vm"
}

variable "vm_size" {
  description = "Size of the VM (use B2s for free tier)"
  type        = string
  default     = "Standard_B1s"  # 2 vCPUs, 4GB RAM - Free tier eligible
}

variable "admin_username" {
  description = "Admin username for SSH access"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Your SSH public key for VM access"
  type        = string
  # Get this by running: cat ~/.ssh/id_rsa.pub
}