# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "instance-1-postgres"
  machine_type = "e2-medium"
  zone         = "us-west1-a"
  tags         = ["ssh"]

  metadata = {
    enable-oslogin = "TRUE"
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = "40"
    }
  }

  # Install Packets 
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync git gcc"

  network_interface {
    network = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}