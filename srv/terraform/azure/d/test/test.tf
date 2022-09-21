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

/*   machine_type = "e2-medium" vCPU 2 Memory 4 GB*/
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



/*
A key set in project metadata is propagated to every instance in the project.
This resource configuration is prone to causing frequent diffs as Google adds SSH Keys when the SSH Button is pressed in the console.
It is better to use OS Login instead.
*/
resource "google_compute_project_metadata" "my_ssh_key" {
  metadata = {
    ssh-keys = <<EOF
      dev:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILg6UtHDNyMNAh0GjaytsJdrUxjtLy3APXqZfNZhvCeT dev
      foo:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILg6UtHDNyMNAh0GjaytsJdrUxjtLy3APXqZfNZhvCeT bar
    EOF
  }
}









