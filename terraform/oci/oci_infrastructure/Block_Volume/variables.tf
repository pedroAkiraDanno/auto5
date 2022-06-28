
    // Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.
    // Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

    variable "compartment_ocid" {}
    variable "availability_domain" {}
    


    variable "block_volume_size_in_gbs" {
      type = number
      default = 50
    }

    variable "block_volume_display_name" {}

    variable "backup_policy_name" {
      type = string
      default = "Bronze"
    }
    
    variable "add_volume_to_volume_group" {} 
    
    /* variable "defined_tags" {
      type = map(string)
    }
    variable "freeform_tags" {
      type = map(string)
    } */

    variable "source_id" {
      type = string
      default = ""
    }
    variable "source_type" {
      type = string
      default = "volume"
    }
    
    variable "volume_group_display_name" {
      type = string
      default = ""
    }
    
    variable "kms_key_id" {
      type = string
      default = ""
    }
    
    variable "backup_policy" {
      type = map(string)
      default = {
        "Bronze" = 1
        "Gold"   = 2
        "Silver" = 0
      }
    }
  