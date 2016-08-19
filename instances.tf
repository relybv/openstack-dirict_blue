resource "openstack_compute_servergroup_v2" "appl" {
  name = "appl"
  policies = ["anti-affinity"]
}

resource "openstack_compute_instance_v2" "lb1" {
  name = "${var.customer}-${var.environment}-${var.lb1_hostname}"
  region = "${var.region}"
  image_name = "${var.image_ub}"
  flavor_name = "${var.flavor_lb}"
  key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  security_groups = [ "${openstack_compute_secgroup_v2.lb.name}" ]
  floating_ip = "${openstack_compute_floatingip_v2.lb.address}"
  user_data = "${template_file.init_lb.rendered}"
  network {
    uuid = "${openstack_networking_network_v2.frontend.id}"
    fixed_ip_v4 = "${var.lb1_ip_address}"
  }
}

resource "openstack_compute_instance_v2" "appl1" {
  name = "${var.customer}-${var.environment}-${var.appl1_hostname}"
  region = "${var.region}"
  image_name = "${var.image_deb}"
  flavor_name = "${var.flavor_appl}"
  key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  security_groups = [ "${openstack_compute_secgroup_v2.frontnet.name}" ]
  user_data = "${template_file.init_appl.rendered}"
  network {
    uuid = "${openstack_networking_network_v2.frontend.id}"
    fixed_ip_v4 = "${var.appl1_ip_address}"
  }
}

resource "openstack_compute_instance_v2" "appl2" {
  name = "${var.customer}-${var.environment}-${var.appl2_hostname}"
  region = "${var.region}"
  image_name = "${var.image_deb}"
  flavor_name = "${var.flavor_appl}"
  key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  security_groups = [ "${openstack_compute_secgroup_v2.frontnet.name}" ]
  user_data = "${template_file.init_appl.rendered}"
  network {
    uuid = "${openstack_networking_network_v2.frontend.id}"
    fixed_ip_v4 = "${var.appl2_ip_address}"
  }
}

resource "openstack_compute_instance_v2" "db1" {
  name = "${var.customer}-${var.environment}-${var.db1_hostname}"
  region = "${var.region}"
  image_name = "${var.image_deb}"
  flavor_name = "${var.flavor_db}"
  key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  security_groups = [ "${openstack_compute_secgroup_v2.backnet.name}" ]
  user_data = "${template_file.init_db.rendered}"
  network {
    uuid = "${openstack_networking_network_v2.backend.id}"
    fixed_ip_v4 = "${var.db1_ip_address}"
  }
  volume {
    volume_id = "${openstack_blockstorage_volume_v1.db1.id}"
    device = "${var.db_storage}"
  }
  volume {
    volume_id = "${openstack_blockstorage_volume_v1.nfs1.id}"
    device = "${var.nfs_storage}"
  }
}

resource "openstack_compute_instance_v2" "monitor1" {
  name = "${var.customer}-${var.environment}-${var.monitor1_hostname}"
  region = "${var.region}"
  image_name = "${var.image_ub}"
  flavor_name = "${var.flavor_mon}"
  key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  security_groups = [ "${openstack_compute_secgroup_v2.monitor.name}" ]
  floating_ip = "${openstack_compute_floatingip_v2.jump.address}"
  user_data = "${template_file.init_monitor.rendered}"
  network {
    uuid = "${openstack_networking_network_v2.frontend.id}"
    fixed_ip_v4 = "${var.monitor1_ip_address}"
  }
  volume {
    volume_id = "${openstack_blockstorage_volume_v1.es1.id}"
    device = "${var.monitor_storage}"
  }
}

resource "openstack_compute_instance_v2" "win1" {
  name = "${var.customer}-${var.environment}-${var.win1_hostname}"
  region = "${var.region}"
  image_name = "${var.image_win}"
  flavor_name = "${var.flavor_win}"
  key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  security_groups = [ "${openstack_compute_secgroup_v2.backnet.name}" ]
  user_data = "${template_file.init_win.rendered}"
  network {
    uuid = "${openstack_networking_network_v2.backend.id}"
    fixed_ip_v4 = "${var.win1_ip_address}"
  }
 }
