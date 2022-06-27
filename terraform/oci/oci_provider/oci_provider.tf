# Variables.
variable "tenancy_ocid"         { type = string sensitive = true }
variable "user_ocid"            { type = string sensitive = true }
variable "private_key_path"     { type = string sensitive = true }
variable "fingerprint"          { type = string sensitive = true }
variable "region"               { type = string sensitive = true }
variable "root_compartment_id"  { type = string sensitive = true }


# Resources
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  private_key_path = var.private_key_path
  fingerprint      = var.fingerprint
  region           = var.region
}