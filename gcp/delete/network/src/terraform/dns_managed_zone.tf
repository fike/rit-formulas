# # dev.escolamais.com

# resource "google_dns_managed_zone" "dns_external" {
#   dns_name   = format("%s%s", var.environment, ".escolamais.com.", )
#   name       = var.environment
#   project    = var.gcp_project
#   visibility = "public"

#   dnssec_config {
#     default_key_specs {
#       algorithm  = "rsasha256"
#       key_length = "2048"
#       key_type   = "keySigning"
#       kind       = "dns#dnsKeySpec"
#     }

#     default_key_specs {
#       algorithm  = "rsasha256"
#       key_length = "1024"
#       key_type   = "zoneSigning"
#       kind       = "dns#dnsKeySpec"
#     }

#     kind          = "dns#managedZoneDnsSecConfig"
#     non_existence = "nsec3"
#     state         = "off"
#   }

# }

# resource "google_dns_record_set" "lets_encrypt" {
#   managed_zone = google_dns_managed_zone.dns_external.name
#   name         = google_dns_managed_zone.dns_external.dns_name
#   project      = var.gcp_project
#   rrdatas      = ["0 issue \"letsencrypt.org\"", "0 issue \"pki.goog\""]
#   ttl          = "300"
#   type         = "CAA"
# }

# # dev.internal
# resource "google_dns_managed_zone" "dns_internal" {
#   name        = format("%s%s", var.network_name, "-internal")
#   dns_name    = format("%s%s", var.environment, ".internal.")
#   description = "Managed by Terraform"
#   labels = {
#     environment = var.environment
#   }

#   visibility = "private"

#   private_visibility_config {
#     networks {
#       network_url = google_compute_network.net.self_link
#     }
#   }
# }
