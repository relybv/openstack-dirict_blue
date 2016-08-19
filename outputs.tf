output "1a. DirICT configuratie overzicht" {
  value = "Versie 1.0"
}
output "1b. Klantnaam" {
    value = "${var.customer}"
}
output "1c. Omgevingsnaam" {
    value = "${var.environment}"
}
output "2a. Load balancer naam" {
    value = "http://${var.ext_lb_name}.${var.environment}.${var.customer}.${var.domain_base}"
}
output "2b. Load balancer publiek IP" {
    value = "${openstack_compute_floatingip_v2.lb.address}"
}
output "3a. Jump host publiek IP" {
    value = "${openstack_compute_floatingip_v2.jump.address}"
}
output "4a. SSH connect string appl1 server" {
    value = "ssh -i ${var.ssh_key_file} ${var.appl_username}@${var.appl1_ip_address} -o 'ProxyCommand ssh -A -i ${var.ssh_key_file} ${var.jump_username}@${openstack_compute_floatingip_v2.jump.address} -W ${var.appl1_ip_address}:22' "
}
output "4b. SSH connect string appl2 server" {
    value = "ssh -i ${var.ssh_key_file} ${var.appl_username}@${var.appl2_ip_address} -o 'ProxyCommand ssh -A -i ${var.ssh_key_file} ${var.jump_username}@${openstack_compute_floatingip_v2.jump.address} -W ${var.appl2_ip_address}:22' "
}
output "4c. SSH connect string db server" {
    value = "ssh -i ${var.ssh_key_file} ${var.db_username}@${var.db1_ip_address} -o 'ProxyCommand ssh -A -i ${var.ssh_key_file} ${var.jump_username}@${openstack_compute_floatingip_v2.jump.address} -W ${var.db1_ip_address}:22' "
}
output "4d. SSH connect string monitor server" {
    value = "ssh -i ${var.ssh_key_file} ${var.mon_username}@${var.monitor1_ip_address} -o 'ProxyCommand ssh -A -i ${var.ssh_key_file} ${var.jump_username}@${openstack_compute_floatingip_v2.jump.address} -W ${var.monitor1_ip_address}:22' "
}
output "5a. Appl1 server intern adres" {
    value = "${var.appl1_ip_address}"
}
output "5b. Appl2 server intern adres" {
    value = "${var.appl2_ip_address}"
}
output "5c. DB server intern adres" {
    value = "${var.db1_ip_address}"
}
output "5d. Monitor server intern adres" {
    value = "${var.monitor1_ip_address}"
}
output "5e. Windows server intern adres" {
    value = "${var.win1_ip_address}"
}
