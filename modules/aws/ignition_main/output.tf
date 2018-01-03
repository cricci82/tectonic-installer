output "ignition" {
  value = "${data.ignition_config.ignition_main.*.rendered}"
}