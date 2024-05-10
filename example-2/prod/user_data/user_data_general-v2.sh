#cloud-config
runcmd:
 - hostnamectl set-hostname $(curl -s http://169.254.169.254/latest/meta-data/tags/instance/Name)
 - echo 'ssh-ed25519  key  devops2@example' >> /home/ubuntu/.ssh/authorized_keys
