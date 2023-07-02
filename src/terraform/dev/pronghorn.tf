resource "kind_cluster" "new" {
  name = "pronghorn"
  config = file("pronghorn.yaml")
  image_version = "1.26"
}
