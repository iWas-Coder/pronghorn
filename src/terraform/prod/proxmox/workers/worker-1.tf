resource "proxmox_vm_qemu" "k8s-w1.pronghorn.org" {
  name = "k8s-w1.pronghorn.org"
  desc = "K8s Worker Node 1"
  target_node = "proxmox"

  clone = "debian-11"
  agent = 1
  cpu = "host"
  sockets = 1
  cores = 4
  memory = 4096

  network {
    bridge = "vmbr0"
    model = "virtio"
  }

  disk {
    storage = "local-lvm"
    type = "virtio"
    size = "40G"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=10.6.5.1/16,gw=10.6.1.1"
  nameserver = "10.6.1.2"
  sshkeys = pathexpand("key.pub")
}
