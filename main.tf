#----------------------
# Create Inventory File
#----------------------

resource "local_file" "ansible_inventory" {
  content = templatefile("./templates/hosts.tpl",
    {
      keyfile     = "${var.pemfile}.pem",
      demoservers = aws_instance.ansible_nodes.*.public_ip
    }
  )
  filename = "./ansible/hosts.cfg"
}

#--------------------------------------
# Create EC2 Ansible Controller Server
#--------------------------------------

resource "aws_instance" "ansible_controller" {
  ami                         = var.amiid
  instance_type               = var.type
  key_name                    = var.pemfile
  associate_public_ip_address = true

  user_data = <<-EOF
        #! /bin/bash
        sudo apt update
        sudo apt install -y ansible
        EOF

  depends_on = [aws_instance.ansible_nodes]
  tags = {
    Name = "ANSIBLE_CONTROLLER"
  }

  provisioner "file" {
    source = "./ansible/hosts.cfg"
    destination = "/home/ubuntu/hosts.cfg"
  }

  provisioner "file" {
    source      = "./${var.pemfile}.pem"
    destination = "/home/ubuntu/${var.pemfile}.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/${var.pemfile}.pem", 
      "chown ubuntu:ubuntu /home/ubuntu/${var.pemfile}.pem"
    ]

  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${var.pemfile}.pem")
    host        = self.public_ip
  }
}

#-------------------------
# Create EC2 Ansible Nodes
#-------------------------

resource "aws_instance" "ansible_nodes" {
  count                       = var.servercount
  ami                         = var.amiid
  instance_type               = var.type
  key_name                    = var.pemfile
  associate_public_ip_address = true

  user_data = <<-EOF
        #! /bin/bash
        sudo apt update
        sudo apt install -y python3
        EOF

  tags = {
    Name = "ANSIBLE TARGET NODES"
  }
}