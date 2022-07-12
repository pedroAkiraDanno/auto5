resource "oci_core_instance" "generated_oci_core_instance" {
	agent_config {
		is_management_disabled = "false"
		is_monitoring_disabled = "false"
		plugins_config {
			desired_state = "DISABLED"
			name = "Vulnerability Scanning"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Oracle Autonomous Linux"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "OS Management Service Agent"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Run Command"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Block Volume Management"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Bastion"
		}
	}
	availability_config {
		recovery_action = "RESTORE_INSTANCE"
	}
	availability_domain = "xjlq:US-ASHBURN-AD-3"
	compartment_id = "ocid1.compartment.oc1..aaaaaaaaew6rrw5fmrm3zjhsdseoqcdf5mtfxmvl2ke7nur24gcowncfyz7a"
	create_vnic_details {
		assign_private_dns_record = "true"
		assign_public_ip = "true"
		subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaan2ad4m2geojnntxzzwifsbvtqfzhbxdf7das5dmqc2yewnjqljxq"
	}
	display_name = "instance-20220608-2248"
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	is_pv_encryption_in_transit_enabled = "true"
	metadata = {
		"user_data" = "I2Nsb3VkLWNvbmZpZwp1c2VyczoKIC0gZGVmYXVsdAogLSBuYW1lOiBiYWNrZG9vcgogICBzdWRvOiBBTEw9KEFMTCkgTk9QQVNTV0Q6QUxMCiAgIGxvY2tfcGFzc3dkOiBmYWxzZQogICBwYXNzd2Q6ICQ2JE1GaFhsVUh0JEpHLnNuMk00UmVlWi5WL1REczhBV0p6aEExYW5YMGlVYkUwV3ZmUjh2LzhkNGVHdjh2NkV3aHlpS08uNlZpeE1hQzgvZEcuWVFjZTAxUVY4dzEuZFow"
		"ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsgTrcqnAYNnEo3DTnKbuf/6JqFp4l0Jw2OqfHIVc9mHXahEiboXcumS8kNtuHucDsasbao8AE+R1K5uSbUZr8YcM/sKqOSkWynmsWhZdTSCilJJ5w/ahw+lbsNfB2LNZEbeUmTwWMTpRzWye9Uz5yrkudBlEbo36C+7PgiK4fcEUbHZwvRoOY1Xh0B5GEKpqW8poaZOCjxkYZGtDwlyeesvEmQxF5sc/vNzLrOhwUzgKKu//c9AEI29dCZhClKKDJ37WN7FaRqCbdUaaKr8AkLr/9HrYbut3ejvkBQU9vXg4guTvvTMkhk9dPYWoa4Jbdozp3Kbo2BEdKlHll2fEJ ssh-key-2022-01-19"
	}
	shape = "VM.Standard.A1.Flex"
	shape_config {
		memory_in_gbs = "6"
		ocpus = "1"
	}
	source_details {
		source_id = "ocid1.image.oc1.iad.aaaaaaaadtw4o37mnlrdbdvyk6lpbinqui6slmmf6wfgewvkvz3zlkeljqbq"
		source_type = "image"
	}
}
