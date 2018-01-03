data "ignition_config" "ignition_main" {
	count = "${var.instance_count}"
  replace {
		source = "s3://${var.bucket}/${var.keys[count.index]}"
    verification = "sha512-${sha512("${var.content[count.index]}")}"
	}
}