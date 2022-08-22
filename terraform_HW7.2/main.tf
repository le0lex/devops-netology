terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version =  ">= 0.13"
}

variable "iam_token" {}

provider yandex {
  token     = "${var.iam_token}"
  cloud_id  = "b1ge7enf5de1k75hpn8d"
  folder_id = "b1g2uo21sas6ji7g03i6"
  zone      = "ru-central1-a"
}

resource yandex_compute_image ubu-img {
  name          = "ubuntu-20-04-lts-v20220718"
  source_image  = "fd826dalmbcl81eo5nig"
}

resource "yandex_vpc_network" "net" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

locals {
  instance = {
  stage = 1
  prod = 2
  }
}

resource "yandex_compute_instance" "vm-count" {
  name = "vm-1"

  resources {
    cores  = "1"
    memory = "2"
  }

  boot_disk {
    initialize_params {
      image_id = "${yandex_compute_image.ubu-img.id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }


}

locals {
  id = toset([
    "1",
    "2",
  ])
}

resource "yandex_compute_instance" "vm-for" {
  
  name = "vm-2"

  resources {
    cores  = "1"
    memory = "2"
  }

  boot_disk {
    initialize_params {
      image_id = "${yandex_compute_image.ubu-img.id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }
}
