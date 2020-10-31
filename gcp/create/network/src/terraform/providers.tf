provider "google-beta" {
    project = var.gcp_project
    version = "~> 3.45"
}


provider "google" {
    project = var.gcp_project
    version = "~> 3.45"
}

# provider "cloudflare" {
#   version = "~> 2.0"
# }
