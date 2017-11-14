output "ignition_master_profile" {
  value = "${data.ignition_config.main.rendered}"
}
