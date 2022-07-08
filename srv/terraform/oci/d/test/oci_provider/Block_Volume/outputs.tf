
      // Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
    
      output "vols" {
        description = "The block volume details"
        value = oci_core_volume.this.*
      }
      
      output "vol_name" {
        description = "The block volume details"
        value = oci_core_volume.this.*.display_name
      }
      
      output "vol_id" {
        description = "The block volume details"
        value = oci_core_volume.this.*.id
      }
      
      output "vol_size" {
        description = "The block volume details"
        value = oci_core_volume.this.*.size_in_gbs
      }
      
      output "vol_groups" {
        description = "The block volume group details"
        value = oci_core_volume_group.this.*
      }
      
      output "vol_group_id" {
        description = "The block volume details"
        value = oci_core_volume_group.this.*.id
      }
      output "vol_group_name" {
        description = "The block volume details"
        value = oci_core_volume_group.this.*.display_name
      }
    