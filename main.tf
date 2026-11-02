provider "local" {}

resource "local_file" "bootstrap_dockerfile" {
filename = "${path.module}/dockerfile"
content = <<-EOF
FROM alpine:latest
CMD ["bash"]
EOF
}

resource "local_file" "bootstrap_dockercompose" {
  filename = "${path.module}/compose.yaml"
  depends_on = [ local_file.bootstrap_dockerfile ]
  content = <<-EOF
services:
    ubuntu-image:
        container_name: "Ubuntu-container"
        hostname: "Ubuntu"
        build:
            context: .
            dockerfile: dockerfile
        restart: always
  EOF
}