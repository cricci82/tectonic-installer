output "ignition_worker_profile" {
  value = "${data.ignition_config.main.rendered}"
}
