variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "nginx"
}
variable "container_hostname" {
  description = "Hostname for the container"
  type = string
  default = "nginx"
}
variable "container_ip" {
  description = "Host IP to bind the published port"
  type = string
  default = "127.0.0.1"
}
