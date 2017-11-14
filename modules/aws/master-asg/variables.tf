variable "assets_s3_location" {
  type        = "string"
  description = "Location on S3 of the Bootkube/Tectonic assets to use (bucket/key)"
}

variable "autoscaling_group_extra_tags" {
  description = "Extra AWS tags to be applied to created autoscaling group resources."
  type        = "list"
  default     = []
}

variable "base_domain" {
  type        = "string"
  description = "Domain on which the ELB records will be created"
}

variable "container_linux_channel" {
  type = "string"
}

variable "container_linux_version" {
  type = "string"
}

variable "cluster_id" {
  type = "string"
}

variable "cluster_name" {
  type = "string"
}

variable "container_images" {
  description = "Container images to use"
  type        = "map"
}

variable "ec2_type" {
  type = "string"
}

variable "extra_tags" {
  description = "Extra AWS tags to be applied to created resources."
  type        = "map"
  default     = {}
}

variable "ign_s3_puller_id" {
  type = "string"
}

variable "image_re" {
  description = "(internal) Regular expression used to extract repo and tag components from image strings"
  type        = "string"
}

variable "instance_count" {
  type = "string"
}

variable "master_iam_role" {
  type        = "string"
  default     = ""
  description = "IAM role to use for the instance profiles of master nodes."
}

variable "master_sg_ids" {
  type        = "list"
  description = "The security group IDs to be applied to the master nodes."
}

variable "public_endpoints" {
  description = "If set to true, public-facing ingress resources are created."
  default     = true
}

variable "aws_lbs" {
  description = "List of aws_lb IDs for the Console & APIs"
  type        = "list"
  default     = []
}

variable "root_volume_iops" {
  type        = "string"
  default     = "100"
  description = "The amount of provisioned IOPS for the root block device."
}

variable "root_volume_size" {
  type        = "string"
  description = "The size of the volume in gigabytes for the root block device."
}

variable "root_volume_type" {
  type        = "string"
  description = "The type of volume for the root block device."
}

variable "ssh_key" {
  type = "string"
}

variable "subnet_ids" {
  type = "list"
}

variable "ign_bootkube_service_id" {
  type        = "string"
  description = "The ID of the bootkube systemd service unit"
}

variable "ign_bootkube_path_unit_id" {
  type = "string"
}

variable "ign_tectonic_service_id" {
  type        = "string"
  description = "The ID of the tectonic installer systemd service unit"
}

variable "ign_tectonic_path_unit_id" {
  type = "string"
}

variable "tectonic_container_linux_cis_hardened" {
  default        = false
}


variable "files_base_list" {
  type      =    "list"
  default   =   [ 
                  "${data.ignition_file.detect_master.id}",
                  "${data.ignition_file.init_assets.id}",
                  "${var.ign_installer_kubelet_env_id}",
                  "${var.ign_max_user_watches_id}",
                  "${var.ign_s3_puller_id}"
                ]
}

variable "files_cis_list" {
  type      =    "list"
  default   =   [ 
                  "${var.ign_fstab_file_id}",
                  "${var.ign_selinuxconfig_file_id}",
                  "${var.ign_issue_file_id}",
                  "${var.ign_issuenet_filenet_id}",
                  "${var.ign_modprobe_file_id}",
                  "${var.ign_sysctlcisconf_file_id}",
                  "${var.ign_su_file_id}",
                  "${var.ign_systemauth_file_id}",
                  "${var.ign_hardner_file_id}",
                ]
}
variable "systemd_base_list" { 
  type    =     "list"
  default =     ["${compact(list(
                  var.ign_docker_dropin_id,
                  var.ign_locksmithd_service_id,
                  var.ign_kubelet_service_id,
                  var.ign_k8s_node_bootstrap_service_id,
                  data.ignition_systemd_unit.init_assets.id,
                  var.ign_bootkube_service_id,
                  var.ign_tectonic_service_id,
                  var.ign_bootkube_path_unit_id,
                  var.ign_tectonic_path_unit_id,
                ))}"]
}

variable "systemd_cis_list" { 
  type    =     "list"
  default =     ["${compact(list(
                  data.ignition_systemd_unit.tmpmount.id,
                  data.ignition_systemd_unit.varmount.id,
                  data.ignition_systemd_unit.vartmpmount.id,
                  data.ignition_systemd_unit.varlogmount.id,
                  data.ignition_systemd_unit.varauditmount.id,
                  data.ignition_systemd_unit.homemount.id,
                  data.ignition_systemd_unit.bootmount.id,
                  data.ignition_systemd_unit.hardner.id,
                ))}"]
}

variable "ign_issuenet_file_id" {
  type = "string"
}