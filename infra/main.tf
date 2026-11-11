# ==============================
# While using Docker as provider
# additional provider is required
# https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs
# ==============================

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.2.0"
    }
  }
}

# ==============================
# Starting the Docker provider
# with the latest image from nginx
# ==============================

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# ==============================
# Specifying resource for projects
# Docker container
# ==============================

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
    host_path = abspath("${path.module}/../html")
    container_path = "/usr/share/nginx/html"
    read_only = true
  }
}

