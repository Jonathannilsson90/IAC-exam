provider "local" {}

resource "local_file" "bootstrap_dockerfile" {
filename = "${path.module}/dockerfile"
content = <<-EOF
FROM ubuntu:latest
CMD ["sleep", "infinity"]
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
        networks:
            vpcbr:
                ipv4_address: 10.5.0.5

networks:
    vpcbr:
        driver: bridge
        ipam:
            config:
                - subnet: 10.5.0.0/16
                  gateway: 10.5.0.1      
  EOF
}