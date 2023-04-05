provider "kind" {
  provider = "docker"
  kubeconfig = pathexpand("~/.kube/pronghorn.yaml")
}
