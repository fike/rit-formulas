# resource "google_compute_security_policy" "policy" {
#   name    = "cloudflare-whitelist"
#   description = "Whitelist for CloudFlare CDN acesss"
#   project = var.gcp_project
#   dynamic "rule" {
#     iterator = cf_ip
#     for_each = var.ip_list 
#     content {
#       description = "Cloudflare IP Range"
#       action   = "allow"
#       preview  = false
#       priority = cf_ip.key

#       match {
#         versioned_expr = "SRC_IPS_V1"

#         config {
#           src_ip_ranges = [cf_ip.value]
#         }
#       }

#     }
#   }

#   rule {
#     action      = "deny(403)"
#     description = "Default rule, higher priority overrides it"
#     preview     = false
#     priority    = 2147483647

#     match {
#       versioned_expr = "SRC_IPS_V1"

#       config {
#         src_ip_ranges = [
#           "*",
#         ]
#       }
#     }
#   }

#   timeouts {}
# }
