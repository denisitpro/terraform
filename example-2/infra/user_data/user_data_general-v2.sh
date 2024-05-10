#cloud-config
runcmd:
 - hostnamectl set-hostname $(curl -s http://169.254.169.254/latest/meta-data/tags/instance/Name)
 - echo 'key devops@example' >> /home/ubuntu/.ssh/authorized_keys
