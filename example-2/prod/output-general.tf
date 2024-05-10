output "exchange_private_link_dns_record_1" {
  value = module.vpc_eu_west_2.exchange_private_link_endpoint[0].hosted_zone_id
}
