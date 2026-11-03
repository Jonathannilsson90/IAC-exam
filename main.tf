
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.2.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name
  hostname = var.container_hostname
  ports {
    internal = 80
    external = 8080
    ip = var.container_ip
    protocol = "tcp"
  }
  volumes {
    host_path = abspath("${path.module}/html")
    container_path = "/usr/share/nginx/html"
    read_only = true
  }
}