resource "null_resource" "post_checks_lb1" {
  triggers {
    cluster_instance_ids = "${openstack_compute_instance_v2.lb1.id}"
  }
  connection {
    host = "${openstack_compute_floatingip_v2.lb.address}"
    user = "${var.lb_username}"
    private_key = "${var.ssh_key_file}"
  }
  provisioner "remote-exec" {
    script = "wait_provision.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo /opt/puppetlabs/puppet/bin/rspec /usr/local/rspec_tests/ -f d"
    ]
  }
}
resource "null_resource" "post_checks_monitor1" {
  triggers {
    cluster_instance_ids = "${openstack_compute_instance_v2.monitor1.id}"
  }
  connection {
    host = "${openstack_compute_floatingip_v2.jump.address}"
    user = "${var.mon_username}"
    private_key = "${var.ssh_key_file}"
  }
  provisioner "remote-exec" {
    script = "wait_provision.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo /opt/puppetlabs/puppet/bin/rspec /usr/local/rspec_tests/ -f d"
    ]
  }
}

resource "null_resource" "post_checks_appl1" {
  triggers {
    cluster_instance_ids = "${openstack_compute_instance_v2.appl1.id}"
  }
  connection {
    bastion_host = "${openstack_compute_floatingip_v2.jump.address}"
    bastion_user = "${var.jump_username}"
    bastion_private_key = "${var.ssh_key_file}"
    host = "${var.appl1_ip_address}"
    user = "${var.appl_username}"
    private_key = "${var.ssh_key_file}"
  }
  provisioner "remote-exec" {
    script = "wait_provision.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo /opt/puppetlabs/puppet/bin/rspec /usr/local/rspec_tests/ -f d"
    ]
  }
}

resource "null_resource" "post_checks_appl2" {
  triggers {
    cluster_instance_ids = "${openstack_compute_instance_v2.appl2.id}"
  }
  connection {
    bastion_host = "${openstack_compute_floatingip_v2.jump.address}"
    bastion_user = "${var.jump_username}"
    bastion_private_key = "${var.ssh_key_file}"
    host = "${var.appl2_ip_address}"
    user = "${var.appl_username}"
    private_key = "${var.ssh_key_file}"
  }
  provisioner "remote-exec" {
    script = "wait_provision.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo /opt/puppetlabs/puppet/bin/rspec /usr/local/rspec_tests/ -f d"
    ]
  }
}

resource "null_resource" "post_checks_db1" {
  triggers {
    cluster_instance_ids = "${openstack_compute_instance_v2.db1.id}"
  }
  connection {
    bastion_host = "${openstack_compute_floatingip_v2.jump.address}"
    bastion_user = "${var.jump_username}"
    bastion_private_key = "${var.ssh_key_file}"
    host = "${var.db1_ip_address}"
    user = "${var.db_username}"
    private_key = "${var.ssh_key_file}"
  }
  provisioner "remote-exec" {
    script = "wait_provision.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo /opt/puppetlabs/puppet/bin/rspec /usr/local/rspec_tests/ -f d"
    ]
  }
}
