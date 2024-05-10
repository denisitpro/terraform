variable "port_prom_egress_tcp" {
  type    = list(number)
  default = [9536, 9100, 9115, 9116, 9222, 9363, 10000]
}

#### inbound and outbound ports


/* ingress rules */
#variable "port_ingress_udp_all" {
#  type    = list(number)
#  default = [33434]
#}

#### egress ports
variable "port_egress_tcp_all" {
  type    = list(number)
  default = [53, 80, 123, 443]
}

variable "port_egress_udp_all" {
  type    = list(number)
  default = [53, 123]
}

variable "port_egress_ipa_both" {
  type    = list(number)
  default = [88, 389, 464, 636]
}