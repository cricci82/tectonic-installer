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
output "cis_sda_disk_id" {
  value = "${data.ignition_disk.sda.id}"
}

output "cis_sda_disk_rendered" {
  value = "${data.ignition_disk.sda.rendered}"
}

output "cis_var_filesystem_id" {
  value = "${data.ignition_filesystem.var.id}"
}

output "cis_var_filesystem_rendered" {
  value = "${data.ignition_filesystem.var.rendered}"
}

output "cis_log_filesystem_id" {
  value = "${data.ignition_filesystem.log.id}"
}

output "cis_log_filesystem_rendered" {
  value = "${data.ignition_filesystem.log.rendered}"
}

output "cis_audit_filesystem_id" {
  value = "${data.ignition_filesystem.audit.id}"
}

output "cis_audit_filesystem_rendered" {
  value = "${data.ignition_filesystem.audit.rendered}"
}

output "cis_home_filesystem_id" {
  value = "${data.ignition_filesystem.home.id}"
}

output "cis_home_filesystem_rendered" {
  value = "${data.ignition_filesystem.home.rendered}"
}

output "cis_fstab_file_id" {
  value = "${data.ignition_file.fstab.id}"
}

output "cis_fstab_file_rendered" {
  value = "${data.ignition_file.fstab.rendered}"
}

output "cis_selinuxconfig_file_id" {
  value = "${data.ignition_file.selinuxconfig.id}"
}

output "cis_selinuxconfig_file_rendered" {
  value = "${data.ignition_file.selinuxconfig.rendered}"
}

output "cis_issue_file_id" {
  value = "${data.ignition_file.issue.id}"
}

output "cis_issue_file_rendered" {
  value = "${data.ignition_file.issue.rendered}"
}

output "cis_issuenet_file_id" {
  value = "${data.ignition_file.issuenet.id}"
}

output "cis_issuenet_file_rendered" {
  value = "${data.ignition_file.issuenet.rendered}"
}

output "cis_modprobe_file_id" {
  value = "${data.ignition_file.modprobecisconf.id}"
}

output "cis_modprobe_file_rendered" {
  value = "${data.ignition_file.modprobecisconf.rendered}"
}

output "cis_sysctlcisconf_file_id" {
  value = "${data.ignition_file.sysctlcisconf.id}"
}

output "cis_sysctlcisconf_file_rendered" {
  value = "${data.ignition_file.sysctlcisconf.rendered}"
}

output "cis_su_file_id" {
  value = "${data.ignition_file.su.id}"
}

output "cis_su_file_rendered" {
  value = "${data.ignition_file.su.rendered}"
}

output "cis_systemauth_file_id" {
  value = "${data.ignition_file.systemauth.id}"
}

output "cis_systemauth_file_rendered" {
  value = "${data.ignition_file.systemauth.rendered}"
}

output "cis_hardner_file_id" {
  value = "${data.ignition_file.hardner.id}"
}

output "cis_hardner_file_rendered" {
  value = "${data.ignition_file.hardner.rendered}"
}



