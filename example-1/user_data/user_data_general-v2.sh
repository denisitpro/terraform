#cloud-config
runcmd:
 - hostnamectl set-hostname $(curl -s http://169.254.169.254/latest/meta-data/tags/instance/Name)
 - echo 'ssh-ed25519 key1 denisitpro2@example' >> /home/ubuntu/.ssh/authorized_keys
 - echo 'ssh-rsa key2 user2@example'   >> /home/ubuntu/.ssh/authorized_keys