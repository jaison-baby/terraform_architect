variable "lb_sg" {
  description = "lb sg"
}
variable "lb_subnet" {
  description = "lb subnet"
}
variable "lb_subnet2" {
  description = "lb subnet"
}

variable "lb_vpc" {
  description = "lb vpc"
}

variable "lb_instance" {
  description = " nginx server instance id"
}
variable "acm_certificate" {
  description = "new acm cert"
}
variable "load_balancer_type" {
    description = "specify load-balancer type"
}
