terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.87.0"
    }
  }
}

provider "google" {
  project = "project"
}

resource "google_compute_instance" "test" {
  name         = "test-instance"
  machine_type = "e2-medium"
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
  }
  attached_disk {
    initialize_params {
      name = "disk"
      size = 10
      type = "pd-balanced"
    }
  }
}