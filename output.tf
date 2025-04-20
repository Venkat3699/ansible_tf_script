output "inventory_file" {
  value = local_file.ansible_inventory.filename
}

output "demoservers_ips" {
  value = aws_instance.ansible_nodes.*.public_ip
}
