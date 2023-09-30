output "domain" {
  value = module.identity_domain.domain
}
output "idcs_endpoint" {
  value = module.identity_domain.domain.url
}