resource "google_compute_disk" "tst-disk1" {
    name         = "tst-disk1"
    zone         = "us-west1-a"
    type         = "pd-balanced"
}