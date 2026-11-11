output "container_id" {
description = "ID of the Docker container"
value = docker_container.nginx.id
}

output "image_id" {
description = "ID of the Docker image"
value = docker_image.nginx.id
}

output "docker_name" {
description = "Container name"
value = docker_container.nginx.name
}

output "url" {
description = "Container IP on the Docker container"
value = var.container_ip
}