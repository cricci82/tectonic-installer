output "ip_addresses" {
  value = "${aws_instance.etcd_node.*.private_ip}"
}

output "ignition_etcd_profile" {
  value = "${data.ignition_config.etcd.rendered}"
}
