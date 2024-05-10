
output "wg_interface_id" {
  description = "Network interface ID of the EC2 instance"
  value       = aws_instance.wg_c1_infra_euc1[0].primary_network_interface_id
}