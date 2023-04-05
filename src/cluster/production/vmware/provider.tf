variable "vsphere_url" {
  type = string
}

variable "vsphere_user" {
  type = string
  sensitive = true
}

variable "vsphere_password" {
  type = string
  sensitive = true
}

provider "vsphere" {
  vsphere_server = var.vsphere_url
  user = var.vsphere_user
  password = var.vsphere_password
}
