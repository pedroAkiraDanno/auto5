resource "google_compute_disk" "tst-disk1" {
    name         = "tst-disk1"
    image        = "debian-cloud/debian-10-buster-v20210217"
    zone         = "us-central1-a"
    type         = "pd-balanced"
}