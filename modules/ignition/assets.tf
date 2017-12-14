data "template_file" "max_user_watches" {
  template = "${file("${path.module}/resources/sysctl.d/max-user-watches.conf")}"
}

data "ignition_file" "max_user_watches" {
  filesystem = "root"
  path       = "/etc/sysctl.d/10-max-user-watches.conf"
  mode       = 0644

  content {
    content = "${data.template_file.max_user_watches.rendered}"
  }
}

data "template_file" "docker_dropin" {
  template = "${file("${path.module}/resources/dropins/10-dockeropts.conf")}"
}

data "ignition_systemd_unit" "docker_dropin" {
  name   = "docker.service"
  enable = true

  dropin = [
    {
      name    = "10-dockeropts.conf"
      content = "${data.template_file.docker_dropin.rendered}"
    },
  ]
}

data "template_file" "kubelet" {
  template = "${file("${path.module}/resources/services/kubelet.service")}"

  vars {
    cloud_provider        = "${var.cloud_provider}"
    cloud_provider_config = "${var.cloud_provider_config != "" ? "--cloud-config=/etc/kubernetes/cloud/config" : ""}"
    cluster_dns_ip        = "${var.kube_dns_service_ip}"
    cni_bin_dir_flag      = "${var.kubelet_cni_bin_dir != "" ? "--cni-bin-dir=${var.kubelet_cni_bin_dir}" : ""}"
    kubeconfig_fetch_cmd  = "${var.kubeconfig_fetch_cmd != "" ? "ExecStartPre=${var.kubeconfig_fetch_cmd}" : ""}"
    node_label            = "${var.kubelet_node_label}"
    node_taints_param     = "${var.kubelet_node_taints != "" ? "--register-with-taints=${var.kubelet_node_taints}" : ""}"
  }
}

data "ignition_systemd_unit" "kubelet" {
  name    = "kubelet.service"
  enable  = true
  content = "${data.template_file.kubelet.rendered}"
}

data "template_file" "k8s_node_bootstrap" {
  template = "${file("${path.module}/resources/services/k8s-node-bootstrap.service")}"

  vars {
    bootstrap_upgrade_cl     = "${var.bootstrap_upgrade_cl}"
    kubeconfig_fetch_cmd     = "${var.kubeconfig_fetch_cmd != "" ? "ExecStartPre=${var.kubeconfig_fetch_cmd}" : ""}"
    tectonic_torcx_image_url = "${replace(var.container_images["tectonic_torcx"],var.image_re,"$1")}"
    tectonic_torcx_image_tag = "${replace(var.container_images["tectonic_torcx"],var.image_re,"$2")}"
    torcx_skip_setup         = "${var.tectonic_vanilla_k8s ? "true" : "false" }"
    torcx_store_url          = "${var.torcx_store_url}"
  }
}

data "ignition_systemd_unit" "k8s_node_bootstrap" {
  name    = "k8s-node-bootstrap.service"
  enable  = true
  content = "${data.template_file.k8s_node_bootstrap.rendered}"
}

data "ignition_systemd_unit" "init_assets" {
  name    = "init-assets.service"
  enable  = "${var.assets_location != "" ? true : false}"
  content = "${file("${path.module}/resources/services/init-assets.service")}"
}

data "template_file" "s3_puller" {
  template = "${file("${path.module}/resources/bin/s3-puller.sh")}"

  vars {
    awscli_image = "${var.container_images["awscli"]}"
  }
}

data "ignition_file" "s3_puller" {
  filesystem = "root"
  path       = "/opt/s3-puller.sh"
  mode       = 0755

  content {
    content = "${data.template_file.s3_puller.rendered}"
  }
}

data "ignition_systemd_unit" "locksmithd" {
  name = "locksmithd.service"
  mask = true
}

data "template_file" "installer_kubelet_env" {
  template = "${file("${path.module}/resources/kubernetes/kubelet.env")}"

  vars {
    kubelet_image_url = "${replace(var.container_images["hyperkube"],var.image_re,"$1")}"
    kubelet_image_tag = "${replace(var.container_images["hyperkube"],var.image_re,"$2")}"
  }
}

data "ignition_file" "installer_kubelet_env" {
  filesystem = "root"
  path       = "/etc/kubernetes/installer/kubelet.env"
  mode       = 0644

  content {
    content = "${data.template_file.installer_kubelet_env.rendered}"
  }
}

data "template_file" "tx_off" {
  template = "${file("${path.module}/resources/services/tx-off.service")}"
}

data "ignition_systemd_unit" "tx_off" {
  name    = "tx-off.service"
  enable  = true
  content = "${data.template_file.tx_off.rendered}"
}

data "template_file" "azure_udev_rules" {
  template = "${file("${path.module}/resources/udev/66-azure-storage.rules")}"
}

data "ignition_file" "azure_udev_rules" {
  filesystem = "root"
  path       = "/etc/udev/rules.d/66-azure-storage.rules"
  mode       = 0644

  content {
    content = "${data.template_file.azure_udev_rules.rendered}"
  }
}

data "template_file" "coreos_metadata" {
  template = "${file("${path.module}/resources/services/coreos-metadata.service")}"

  vars {
    metadata_provider = "${var.metadata_provider}"
  }
}

data "ignition_systemd_unit" "coreos_metadata" {
  name   = "coreos-metadata.service"
  enable = true

  dropin = [
    {
      name    = "10-metadata.conf"
      content = "${data.template_file.coreos_metadata.rendered}"
    },
  ]
}

# CIS Benchmark

data "ignition_disk" "sda" {
  device     = "/dev/xvda"
  wipe_table = true

  partition {
    # 1.1.6 Ensure separate partition exists for /var
    label  = "VAR"
    number = 1
    size   = 4
  }

  partition {
    label  = "LOG"
    number = 2
    size   = 4
  }

  partition {
    # 1.1.6 Ensure separate partition exists for /var
    label  = "AUDIT"
    number = 3
    size   = 4
  }

  partition {
    label  = "HOME"
    number = 4
    size   = 4
  }
 
}

data "ignition_filesystem" "var" {
  name = "var"

  mount {
    device  = "/dev/disk/by-partlabel/VAR"
    format  = "ext4"
    create  = true
    options = ["-L", "VAR"]
  }
}

data "ignition_filesystem" "log" {
  name = "log"

  mount {
    device  = "/dev/disk/by-partlabel/LOG"
    format  = "ext4"
    create  = true
    options = ["-L", "LOG"]
  }
}

data "ignition_filesystem" "audit" {
  name = "audit"

  mount {
    device  = "/dev/disk/by-partlabel/AUDIT"
    format  = "ext4"
    create  = true
    options = ["-L", "AUDIT"]
  }
}

data "ignition_filesystem" "home" {
  name = "home"

  mount {
    device  = "/dev/disk/by-partlabel/HOME"
    format  = "ext4"
    create  = true
    options = ["-L", "HOME"]
  }
}

data "template_file" "fstab" {
  template = "${file("${path.module}/resources/etc/fstab")}"
}

data "ignition_file" "fstab" {
  filesystem = "root"
  path       = "/etc/fstab"

  content {
    content = "${data.template_file.fstab.rendered}"
  }
}

data "template_file" "selinuxconfig" {
  template = "${file("${path.module}/resources/selinux/config")}"
}

data "ignition_file" "selinuxconfig" {
  filesystem = "root"
  path       = "/etc/selinux/config"

  content {
    content = "${data.template_file.selinuxconfig.rendered}"
  }
}

data "template_file" "issue" {
  template = "${file("${path.module}/resources/etc/issue")}"
}

data "ignition_file" "issue" {
  filesystem = "root"
  path       = "/etc/issue"
  mode       = 0644

  content {
    content = "${data.template_file.issue.rendered}"
  }
}

data "template_file" "issuenet" {
  template = "${file("${path.module}/resources/etc/issue.net")}"
}

data "ignition_file" "issuenet" {
  filesystem = "root"
  path       = "/etc/issue.net"
  mode       = 0644

  content {
    content = "${data.template_file.issuenet.rendered}"
  }
}

data "template_file" "modprobecisconf" {
  template = "${file("${path.module}/resources/modprobe.d/cis.conf")}"
}

data "ignition_file" "modprobecisconf" {
  filesystem = "root"
  path       = "/etc/modprobe.d/cis.conf"
  mode       = 0600

  content {
    content = "${data.template_file.modprobecisconf.rendered}"
  }
}

data "template_file" "sysctlcisconf" {
  template = "${file("${path.module}/resources/sysctl.d/cis.conf")}"
}

data "ignition_file" "sysctlcisconf" {
  filesystem = "root"
  path       = "/etc/sysctl.d/cis.conf"
  mode       = 0600

  content {
    content = "${data.template_file.sysctlcisconf.rendered}"
  }
}

data "template_file" "su" {
  template = "${file("${path.module}/resources/pam.d/su")}"
}

data "ignition_file" "su" {
  filesystem = "root"
  path       = "/etc/pam.d/su"
  mode       = 0644

  content {
    content = "${data.template_file.su.rendered}"
  }
}

data "template_file" "systemauth" {
  template = "${file("${path.module}/resources/pam.d/system-auth")}"
}

data "ignition_file" "systemauth" {
  filesystem = "root"
  path       = "/etc/pam.d/system-auth"
  mode       = 0644

  content {
    content = "${data.template_file.systemauth.rendered}"
  }
}

data "template_file" "hardener" {
  template = "${file("${path.module}/resources/root/hardener.sh")}"
}

data "ignition_file" "hardener" {
  filesystem = "root"
  path       = "/root/hardener.sh"
  mode       = 0700

  content {
    content = "${data.template_file.hardener.rendered}"
  }
}

data "ignition_systemd_unit" "tmpmount" {
  name   = "tmp.mount"
  enable = true

  dropin = [
    {
      name = "no-exec.conf"

      content = <<EOF
[Mount]
Options=mode=1777,strictatime,nosuid,nodev,noexec
EOF
    },
  ]
}

data "ignition_systemd_unit" "varmount" {
  name   = "var.mount"
  enable = true

  content = <<EOF
[Unit]
Conflicts=umount.target
Before=local-fs.target umount.target

[Mount]
What=/dev/disk/by-label/VAR
Where=/var
EOF
}

data "ignition_systemd_unit" "vartmpmount" {
  name   = "var-tmp.mount"
  enable = true

  content = <<EOF
[Unit]
DefaultDependencies=no
Conflicts=umount.target
Before=local-fs.target umount.target
After=swap.target

[Mount]
What=tmpfs
Where=/var/tmp
Type=tmpfs
Options=mode=1777,strictatime,nosuid,nodev,noexec

[Install]
RequiredBy=local-fs.target
EOF
}

data "ignition_systemd_unit" "varlogmount" {
  name   = "var-log.mount"
  enable = true

  content = <<EOF
[Unit]
DefaultDependencies=no
Conflicts=umount.target
Before=local-fs.target umount.target

[Mount]
What=/dev/disk/by-label/LOG
Where=/var/log

[Install]
RequiredBy=local-fs.target
EOF
}

data "ignition_systemd_unit" "varauditmount" {
  name   = "var-log-audit.mount"
  enable = true

  content = <<EOF
[Unit]
DefaultDependencies=no
Conflicts=umount.target
Before=local-fs.target umount.target

[Mount]
What=/dev/disk/by-label/AUDIT
Where=/var/log/audit

[Install]
RequiredBy=local-fs.target
EOF
}

data "ignition_systemd_unit" "homemount" {
  name   = "home.mount"
  enable = true

  content = <<EOF
[Unit]
DefaultDependencies=no
Conflicts=umount.target
Before=local-fs.target umount.target

[Mount]
What=/dev/disk/by-label/HOME
Where=/home
Options=nodev

[Install]
RequiredBy=local-fs.target
EOF
}

data "ignition_systemd_unit" "bootmount" {
  name   = "boot.mount"
  enable = true

  dropin = [
    {
      name = "noread.conf"

      content = <<EOF
[Mount]
Options=rw,relatime,fmask=0077,dmask=0022,codepage=437,iocharset=ascii
EOF
    },
  ]
}

data "ignition_systemd_unit" "hardener" {
  name   = "hardener.service"
  enable = true

  content = <<EOF
[Unit]
Description=CIS Hardener
ConditionFirstBoot=yes

[Service]
Type=oneshot
ExecStart=/root/hardener.sh

[Install]
WantedBy=multi-user.target
EOF
}
