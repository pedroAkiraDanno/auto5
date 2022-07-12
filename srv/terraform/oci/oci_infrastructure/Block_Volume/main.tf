
    // Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.
    // Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
    
    terraform {
      required_version = ">= 0.12.0"
    }
    
    locals {
      vols_default = {
        compartment_id     = ""
        name               = "test-volume"
        ad                 = 0
        size_in_gbs        = 50
        backup_policy_name = "Bronze"
        defined_tags       = {}
        freeform_tags      = {}
        source_id          = null
        source_type        = "volume"
        kms_key_id         = null
        volume_group_display_name = "test-vol-group"
      }
    }
    
    resource "oci_core_volume" "this" {
        #Required
        #availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[local.vols_default.ad], "name")
        availability_domain = var.availability_domain
        compartment_id = var.compartment_ocid
    
        #Optional
        #backup_policy_id = lookup(data.oci_core_volume_backup_policies.volume_backup_policies.volume_backup_policies[var.backup_policy[var.backup_policy_name]], "id")
        defined_tags = null
        display_name = var.block_volume_display_name
        freeform_tags = null
        kms_key_id = var.kms_key_id != "" ? var.kms_key_id : null
        size_in_gbs = var.block_volume_size_in_gbs
    
        dynamic "source_details" {
        for_each = var.source_id != "" ? ["1"] : []
        content {
          id   = var.source_id != "" ? var.source_id : null
          type = var.source_type != null ? var.source_type : local.vols_default.source_type
        }
      }
    }
    
    resource "oci_core_volume_group" "this" {
        #Required
        count = var.add_volume_to_volume_group ? 1 : 0
        availability_domain = var.availability_domain
        #availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[local.vols_default.ad], "name")
        compartment_id = var.compartment_ocid
        source_details {
            #Required
            type = "volumeIds"
            volume_ids = var.add_volume_to_volume_group ? oci_core_volume.this.*.id : []
        }
        #Optional
        defined_tags = null
        display_name = var.add_volume_to_volume_group ? ( var.volume_group_display_name != "" ? var.volume_group_display_name : local.vols_default.volume_group_display_name): null
        freeform_tags = null
    }
   
    