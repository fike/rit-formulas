terraform {
  required_version = ">= 0.13"
}

# Network
resource "google_compute_network" "net" {
  name                    = format("%s%s", "net-", var.environment)
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "subnet" {
  name          = format("%s%s", "subnet-", var.environment)
  ip_cidr_range = var.ip_range
  region        = var.region
  network       = google_compute_network.net.self_link
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "outbound-router"
  network = google_compute_network.net.name
  region = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = format("%s%s", "nat-", var.environment)
  router                             = google_compute_router.router.name
  region                             = google_compute_subnetwork.subnet.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
  depends_on = [google_compute_router.router]
}

# Firewall
resource "google_compute_firewall" "ssh" {
  name    = format("%s%s", "ssh-firewall-", var.environment)
  network = google_compute_network.net.self_link

  allow {
    protocol = "tcp"
    ports    = [var.ssh_port]
  }

  source_ranges = [var.allow_all_ranges]
  source_tags   = [var.tag_ssh]
  target_tags   = [var.tag_ssh]
}

resource "google_compute_firewall" "icmp" {
  name    = format("%s%s", "icmp-firewall-", var.environment)
  network = google_compute_network.net.self_link

  allow {
    protocol = "icmp"
  }

  source_ranges = [var.allow_all_ranges]
  source_tags   = [var.tag_icmp]
  target_tags   = [var.tag_icmp]
}

resource "google_compute_firewall" "http" {
  name    = format("%s%s", "http-firewall-", var.environment)
  network = google_compute_network.net.self_link

  allow {
    protocol = "tcp"
    ports    = [var.http_port]
  }

  source_ranges = [var.allow_all_ranges]
  target_tags   = [var.tag_http]
}

resource "google_compute_firewall" "https" {
  name    = format("%s%s", "https-firewall-", var.environment)
  network = google_compute_network.net.self_link

  allow {
    protocol = "tcp"
    ports    = [var.https_port]
  }

  source_ranges = [var.allow_all_ranges]
  target_tags   = [var.tag_https]
}


# resource "google_compute_firewall" "nodejs" {
#   name    = format("%s%s", "node-firewall-", var.environment)
#   network = google_compute_network.net.self_link

#   allow {
#     protocol = "tcp"
#     ports    = [var.nodejs_port]
#   }

#   source_ranges = [var.allow_all_ranges]
#   target_tags   = [var.tag_nodejs]
# }

# resource "google_compute_firewall" "django" {
#   name    = format("%s%s", "django-firewall-", var.environment)
#   network = google_compute_network.net.self_link

#   allow {
#     protocol = "tcp"
#     ports    = [var.django_port]
#   }

#   source_ranges = [var.allow_all_ranges]
#   target_tags   = [var.tag_django]
# }

