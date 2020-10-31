resource "google_compute_ssl_policy" "default_policy" {
  name            = "default-policy"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}