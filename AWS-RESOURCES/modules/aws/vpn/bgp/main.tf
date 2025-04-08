resource "aws_vpn_gateway_attachment" "this" {
  vpc_id         = var.vpc_id
  vpn_gateway_id = var.aws_vpn_gateway
}

resource "aws_customer_gateway" "this" {
  bgp_asn    = var.customer_gateway_settings["bgp_asn"]
  ip_address = var.customer_gateway_settings["ip_address"]
  type       = var.customer_gateway_settings["type"]

  tags = {
    Name = var.identifier == null ? format("%s-customer-gateway", local.resource_name) : format("%s-%s-customer-gateway", local.resource_name, var.identifier)
  }
}

resource "aws_vpn_connection" "this" {
  vpn_gateway_id      = var.aws_vpn_gateway
  customer_gateway_id = aws_customer_gateway.this.id
  type                = var.vpn_connection_settings["type"]
  static_routes_only  = var.vpn_connection_settings["static_routes_only"]

  tunnel1_preshared_key                = var.tunnel1_preshared_key
  tunnel1_ike_versions                 = var.tunnel1_ike_versions
  tunnel1_phase1_encryption_algorithms = var.tunnel1_phase1_encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.tunnel1_phase1_integrity_algorithms
  tunnel1_phase1_lifetime_seconds      = var.tunnel1_phase1_lifetime_seconds
  tunnel1_phase1_dh_group_numbers      = var.tunnel1_phase1_dh_group_numbers
  tunnel1_dpd_timeout_action           = var.tunnel1_dpd_timeout_action
  tunnel1_phase2_encryption_algorithms = var.tunnel1_phase2_encryption_algorithms
  tunnel1_phase2_integrity_algorithms  = var.tunnel1_phase2_integrity_algorithms
  tunnel1_phase2_lifetime_seconds      = var.tunnel1_phase2_lifetime_seconds
  tunnel1_phase2_dh_group_numbers      = var.tunnel1_phase2_dh_group_numbers
  tunnel2_preshared_key                = var.tunnel1_preshared_key
  tunnel2_dpd_timeout_action           = var.tunnel2_dpd_timeout_action
  tunnel2_ike_versions                 = var.tunnel2_ike_versions
  tunnel2_phase1_dh_group_numbers      = var.tunnel2_phase1_dh_group_numbers
  tunnel2_phase1_encryption_algorithms = var.tunnel2_phase1_encryption_algorithms
  tunnel2_phase1_integrity_algorithms  = var.tunnel2_phase1_integrity_algorithms
  tunnel2_phase1_lifetime_seconds      = var.tunnel2_phase1_lifetime_seconds
  tunnel2_phase2_dh_group_numbers      = var.tunnel2_phase2_dh_group_numbers
  tunnel2_phase2_encryption_algorithms = var.tunnel2_phase2_encryption_algorithms
  tunnel2_phase2_integrity_algorithms  = var.tunnel2_phase2_integrity_algorithms
  tunnel2_phase2_lifetime_seconds      = var.tunnel2_phase2_lifetime_seconds
  tunnel2_startup_action               = var.tunnel2_startup_action

  tags = {
    Name = var.identifier == null ? local.resource_name : format("%s-%s", local.resource_name, var.identifier)
  }

  lifecycle {
    ignore_changes = [
      tunnel2_preshared_key,
      tunnel2_dpd_timeout_action,
      tunnel2_ike_versions,
      tunnel2_phase1_dh_group_numbers,
      tunnel2_phase1_encryption_algorithms,
      tunnel2_phase1_integrity_algorithms,
      tunnel2_phase1_lifetime_seconds,
      tunnel2_phase2_dh_group_numbers,
      tunnel2_phase2_encryption_algorithms,
      tunnel2_phase2_integrity_algorithms,
      tunnel2_phase2_lifetime_seconds,
      tunnel2_startup_action,
    ]
  }
}

resource "aws_vpn_connection_route" "this" {
  count = var.vpn_connection_settings["static_routes_only"] ? 1 : 0

  destination_cidr_block = var.vpn_connection_settings["route"]
  vpn_connection_id      = aws_vpn_connection.this.id
}

resource "aws_vpn_gateway_route_propagation" "private" {
  vpn_gateway_id = var.aws_vpn_gateway
  route_table_id = var.private_route_table_id
}

resource "aws_vpn_gateway_route_propagation" "public" {
  vpn_gateway_id = var.aws_vpn_gateway
  route_table_id = var.public_route_table_id
}
