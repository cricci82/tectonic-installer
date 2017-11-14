output "max_user_watches_id" {
  value = "${data.ignition_file.max_user_watches.id}"
}

output "max_user_watches_rendered" {
  value = "${data.template_file.max_user_watches.rendered}"
}

output "docker_dropin_id" {
  value = "${data.ignition_systemd_unit.docker_dropin.id}"
}

output "docker_dropin_rendered" {
  value = "${data.template_file.docker_dropin.rendered}"
}

output "kubelet_service_id" {
  value = "${data.ignition_systemd_unit.kubelet.id}"
}

output "kubelet_service_rendered" {
  value = "${data.template_file.kubelet.rendered}"
}

output "k8s_node_bootstrap_service_id" {
  value = "${data.ignition_systemd_unit.k8s_node_bootstrap.id}"
}

output "k8s_node_bootstrap_service_rendered" {
  value = "${data.template_file.k8s_node_bootstrap.rendered}"
}

output "init_assets_service_id" {
  value = "${data.ignition_systemd_unit.init_assets.id}"
}

output "s3_puller_id" {
  value = "${data.ignition_file.s3_puller.id}"
}

output "s3_puller_rendered" {
  value = "${data.template_file.s3_puller.rendered}"
}

output "locksmithd_service_id" {
  value = "${data.ignition_systemd_unit.locksmithd.id}"
}

output "installer_kubelet_env_id" {
  value = "${data.ignition_file.installer_kubelet_env.id}"
}

output "installer_kubelet_env_rendered" {
  value = "${data.template_file.installer_kubelet_env.rendered}"
}

output "tx_off_service_id" {
  value = "${data.ignition_systemd_unit.tx_off.id}"
}

output "tx_off_service_rendered" {
  value = "${data.template_file.tx_off.rendered}"
}

output "azure_udev_rules_id" {
  value = "${data.ignition_file.azure_udev_rules.id}"
}

output "azure_udev_rules_rendered" {
  value = "${data.template_file.azure_udev_rules.rendered}"
}

output "etcd_dropin_id_list" {
  value = "${data.ignition_systemd_unit.etcd.*.id}"
}

output "etcd_dropin_rendered_list" {
  value = "${data.template_file.etcd.*.rendered}"
}

output "coreos_metadata_dropin_id" {
  value = "${data.ignition_systemd_unit.coreos_metadata.id}"
}

output "coreos_metadata_dropin_rendered" {
  value = "${data.template_file.coreos_metadata.rendered}"
}

# CIS Hardening
output "ign_sda_disk_id" {
  value = "${data.ignition_disk.sda.id}"
}

output "ign_sda_disk_rendered" {
  value = "${data.ignition_disk.sda.rendered}"
}

output "ign_var_filesystem_id" {
  value = "${data.ignition_filesystem.var.id}"
}

output "ign_var_filesystem_rendered" {
  value = "${data.ignition_filesystem.var.rendered}"
}

output "ign_log_filesystem_id" {
  value = "${data.ignition_filesystem.log.id}"
}

output "ign_log_filesystem_rendered" {
  value = "${data.ignition_filesystem.log.rendered}"
}

output "ign_audit_filesystem_id" {
  value = "${data.ignition_filesystem.audit.id}"
}

output "ign_audit_filesystem_rendered" {
  value = "${data.ignition_filesystem.audit.rendered}"
}

output "ign_home_filesystem_id" {
  value = "${data.ignition_filesystem.home.id}"
}

output "ign_home_filesystem_rendered" {
  value = "${data.ignition_filesystem.home.rendered}"
}

output "ign_fstab_file_id" {
  value = "${data.ignition_file.fstab.id}"
}

output "ign_fstab_file_rendered" {
  value = "${data.ignition_file.fstab.rendered}"
}

output "ign_selinuxconfig_file_id" {
  value = "${data.ignition_file.selinuxconfig.id}"
}

output "ign_selinuxconfig_file_rendered" {
  value = "${data.ignition_file.selinuxconfig.rendered}"
}

output "ign_issue_file_id" {
  value = "${data.ignition_file.issue.id}"
}

output "ign_issue_file_rendered" {
  value = "${data.ignition_file.issue.rendered}"
}

output "ign_issuenet_file_id" {
  value = "${data.ignition_file.issuenet.id}"
}

output "ign_issuenet_file_rendered" {
  value = "${data.ignition_file.issuenet.rendered}"
}

output "ign_modprobe_file_id" {
  value = "${data.ignition_file.modprobecisconf.id}"
}

output "ign_modprobe_file_rendered" {
  value = "${data.ignition_file.modprobecisconf.rendered}"
}

output "ign_sysctlcisconf_file_id" {
  value = "${data.ignition_file.sysctlcisconf.id}"
}

output "ign_sysctlcisconf_file_rendered" {
  value = "${data.ignition_file.sysctlcisconf.rendered}"
}

output "ign_su_file_id" {
  value = "${data.ignition_file.su.id}"
}

output "ign_su_file_rendered" {
  value = "${data.ignition_file.su.rendered}"
}

output "ign_systemauth_file_id" {
  value = "${data.ignition_file.systemauth.id}"
}

output "ign_systemauth_file_rendered" {
  value = "${data.ignition_file.systemauth.rendered}"
}

output "ign_hardener_file_id" {
  value = "${data.ignition_file.hardener.id}"
}

output "ign_hardener_file_rendered" {
  value = "${data.ignition_file.hardener.rendered}"
}

output "ign_tmpmount_service_id" {
  value = "${data.ignition_systemd_unit.tmpmount.id}"
}

output "ign_vartmpmount_service_id" {
  value = "${data.ignition_systemd_unit.vartmpmount.id}"
}

output "ign_varlogmount_service_id" {
  value = "${data.ignition_systemd_unit.varlogmount.id}"
}

output "ign_varauditmount_service_id" {
  value = "${data.ignition_systemd_unit.varauditmount.id}"
}

output "ign_homemount_service_id" {
  value = "${data.ignition_systemd_unit.homemount.id}"
}

output "ign_bootmount_service_id" {
  value = "${data.ignition_systemd_unit.bootmount.id}"
}

output "ign_hardener_service_id" {
  value = "${data.ignition_systemd_unit.hardener.id}"
}
