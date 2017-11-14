data "ignition_config" "main" {
  #disks = ["${var.tectonic_container_linux_cis_hardened ? data.template_file.disks_list.rendered : ""}"]

  #filesystems = ["${var.tectonic_container_linux_cis_hardened ? data.template_file.filesystems_list.rendered : ""}"]

  files = ["${var.tectonic_container_linux_cis_hardened ? data.template_file.files_cis_list.rendered : data.template_file.files_base_list.rendered}"]

  systemd = ["${var.tectonic_container_linux_cis_hardened ? data.template_file.systemd_cis_list.rendered : data.template_file.systemd_base_list.rendered}"]
}

data "ignition_file" "detect_master" {
  filesystem = "root"
  path       = "/opt/detect-master.sh"
  mode       = 0755

  content {
    content = "${file("${path.module}/resources/detect-master.sh")}"
  }
}

data "template_file" "disks_list" {
  template = "${compact(list(
              var.ign_sda_disk_id,
              ))}"
}
/*
data "template_file" "filesystems_list" {
  template = "${compact(list(
                var.ign_var_filesystem_id,
                var.ign_audit_filesystem_id,
                var.ign_log_filesystem_id,
                var.ign_home_filesystem_id,
              ))}"
}
*/
data "template_file" "files_base_list" {
  template = "${list(
              data.ignition_file.detect_master.id,
              data.ignition_file.init_assets.id,
              var.ign_installer_kubelet_env_id,
              var.ign_max_user_watches_id,
              var.ign_s3_puller_id,
              )}"
}

data "template_file" "files_cis_list" {
  template = "${compact(list(
              data.ignition_file.detect_master.id,
              data.ignition_file.init_assets.id,
              var.ign_installer_kubelet_env_id,
              var.ign_max_user_watches_id,
              var.ign_s3_puller_id,
              var.ign_fstab_file_id,
              var.ign_selinuxconfig_file_id,
              var.ign_issue_file_id,
              var.ign_issuenet_file_id,
              var.ign_modprobe_file_id,
              var.ign_sysctlcisconf_file_id,
              var.ign_su_file_id,
              var.ign_systemauth_file_id,
              var.ign_hardener_file_id,
              ))}"
}

data "template_file" "systemd_base_list" {
  template = "${compact(list(
                  var.ign_docker_dropin_id,
                  var.ign_locksmithd_service_id,
                  var.ign_kubelet_service_id,
                  var.ign_k8s_node_bootstrap_service_id,
                  data.ignition_systemd_unit.init_assets.id,
                  var.ign_bootkube_service_id,
                  var.ign_tectonic_service_id,
                  var.ign_bootkube_path_unit_id,
                  var.ign_tectonic_path_unit_id,
                ))}"
}

data "template_file" "systemd_cis_list" {
  template = "${compact(list(
                  var.ign_docker_dropin_id,
                  var.ign_locksmithd_service_id,
                  var.ign_kubelet_service_id,
                  var.ign_k8s_node_bootstrap_service_id,
                  data.ignition_systemd_unit.init_assets.id,
                  var.ign_bootkube_service_id,
                  var.ign_tectonic_service_id,
                  var.ign_bootkube_path_unit_id,
                  var.ign_tectonic_path_unit_id,
                  var.ign_tmpmount_service_id,
                  var.ign_vartmpmount_service_id,
                  var.ign_varlogmount_service_id,
                  var.ign_varauditmount_service_id,
                  var.ign_homemount_service_id,
                  var.ign_bootmount_service_id,
                  var.ign_hardener_service_id,
                ))}"
}

data "template_file" "init_assets" {
  template = "${file("${path.module}/resources/init-assets.sh")}"

  vars {
    cluster_name       = "${var.cluster_name}"
    awscli_image       = "${var.container_images["awscli"]}"
    assets_s3_location = "${var.assets_s3_location}"
    kubelet_image_url  = "${replace(var.container_images["hyperkube"],var.image_re,"$1")}"
    kubelet_image_tag  = "${replace(var.container_images["hyperkube"],var.image_re,"$2")}"
  }
}

data "ignition_file" "init_assets" {
  filesystem = "root"
  path       = "/opt/init-assets.sh"
  mode       = 0755

  content {
    content = "${data.template_file.init_assets.rendered}"
  }
}

data "ignition_systemd_unit" "init_assets" {
  name    = "init-assets.service"
  enable  = "${var.assets_s3_location != "" ? true : false}"
  content = "${file("${path.module}/resources/services/init-assets.service")}"
}
