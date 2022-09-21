#Disk 
resource "google_compute_disk" "default" {
    name         = "tst-disk1"
    zone         = "us-west1-a"
    type         = "pd-balanced"
}


#Disk 2
resource "google_compute_disk" "tst-disk2" {
    name         = "tst-disk2"
    zone         = "us-west1-a"
    type         = "pd-standard"
}


# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "instance-1-postgres"
  machine_type = "e2-medium"
  zone         = "us-west1-a"
  tags         = ["ssh", "http-server", "https-server"]


# Add ssh-keys ssh-key-2022-01-19
  metadata = {
    enable-oslogin = "TRUE"
    ssh-keys = <<EOF
      dev:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILg6UtHDNyMNAh0GjaytsJdrUxjtLy3APXqZfNZhvCeT dev
      ssh-key-2022-01-19:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsgTrcqnAYNnEo3DTnKbuf/6JqFp4l0Jw2OqfHIVc9mHXahEiboXcumS8kNtuHucDsasbao8AE+R1K5uSbUZr8YcM/sKqOSkWynmsWhZdTSCilJJ5w/ahw+lbsNfB2LNZEbeUmTwWMTpRzWye9Uz5yrkudBlEbo36C+7PgiK4fcEUbHZwvRoOY1Xh0B5GEKpqW8poaZOCjxkYZGtDwlyeesvEmQxF5sc/vNzLrOhwUzgKKu//c9AEI29dCZhClKKDJ37WN7FaRqCbdUaaKr8AkLr/9HrYbut3ejvkBQU9vXg4guTvvTMkhk9dPYWoa4Jbdozp3Kbo2BEdKlHll2fEJ ssh-key-2022-01-19 
    EOF    
    
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = "40"
    }
  }

  # Install Packets 
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync git gcc postfix mailutils nmap traceroute neofetch"

  network_interface {
    network = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}


# Connect compute & disk 1 
resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.default.id
}



# Connect compute & disk 2
resource "google_compute_attached_disk" "attached_disk2" {
  disk     = google_compute_disk.tst-disk2.id
  instance = google_compute_instance.default.id
}



