[defaults]
ansible_ssh_common_args = -o StrictHostKeyChecking=no

[demo]
%{ for ip in demoservers ~}
${ip} ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/${keyfile}
%{ endfor ~}
