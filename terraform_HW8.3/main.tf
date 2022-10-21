terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version =  ">= 0.13"
}


provider yandex {
  token     = "t1.9euelZqLmJXKkYnMzIvIi5Gdx82Rye3rnpWazJOVmo-bmpuUzcmays-Jzozl9PcITTZl-e9hAzy03fT3SHszZfnvYQM8tA.2awdEQ9b0Tz70CfCDT52F0LRHQq2AKcs95vXAbTbmTjn0Vot7f8JJ1MgYlLSnzkpd7pEVKi9_YpB7K0Nm77qCw"
  cloud_id  = "b1ge7enf5de1k75hpn8d"
  folder_id = "b1g2uo21sas6ji7g03i6"
  zone      = "ru-central1-a"
}

resource yandex_compute_image ubu-img {
  name          = "centos-8"
  source_image  = "fd88d14a6790do254kj7"
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
  id = toset([
    "clickhouse",
    "vector",
    "lighthouse",
  ])
}

resource "yandex_compute_instance" "vm-for" {
  for_each = local.id
  name = "vm-${each.key}"

  resources {
    cores  = "2"
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


  metadata = {
    ssh-keys = "yc-user:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDmnhCvxvzoE7LAiSqLdc/ElLwGL5YBXAtKujwoZT7gnAxH0M8nMCEv/+4jkAId/gpD2ExWUP2W63GcFiIwXe7b5XGeDIjvn1n7zpoktt78+7ndqaJjBvbW2ZxOACdBCzmQgoM/+DxJH98NZwVeW5rO5XqJUQysVzklZj8dtuMRXX68xT849hTTtRXNmJmeOrm2sRqgUJM4Fo2FaQnieTNiDesQ8CJHK3LbXBLYDBrRNzbLtdFXJx+GtQV6JeYRHcK/HgR+CZ8CAldzXZyZbQLVDcVrLpQVoNTuB9gu8esF6q5CfXLDeONqXY7VtVaf/ZsxFJd1/OEBL9jYB5OA5s4n69qwe7Xd9DkfZag80Qaub2n4JiN0bTArxIPL9UvGP6IHkCOqQGJBkrTqR01SFTfRz5cpWF+WBYt/WeshGnewFTUdz3p22v6jqIdxbgio1m5wyRUFgHqoiq+qGOg/y39noc9WA6r8VSweGMTfu8LIYRNoTv7Q7LwNJx//2EGGmEE= leolex@leolex-VirtualBox"
  }
}
