output "public_dns_app_loadbalancer" {
  value = aws_lb.application-lb.dns_name
}
