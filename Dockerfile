FROM alpine:latest
LABEL MAINTAINER="Chris Alef <chris@crickertech.com>"

# Install essential packages
RUN apk add --no-cache openssh sudo bash shadow curl git \
    # Create vagrant group and user
    && addgroup -S vagrant \
    && adduser -D -s /bin/bash -G vagrant vagrant \
    # Give passwordless sudo
    && echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant \
    && chmod 0440 /etc/sudoers.d/vagrant \
    # Setup .ssh directory
    && mkdir -p /home/vagrant/.ssh \
    # Fetch official Vagrant insecure public key
    && curl -fsSL https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub \
        -o /home/vagrant/.ssh/authorized_keys \
    && chmod 700 /home/vagrant/.ssh \
    && chmod 600 /home/vagrant/.ssh/authorized_keys \
    && chown -R vagrant:vagrant /home/vagrant/.ssh \
    # Generate host keys for sshd
    && ssh-keygen -A \
    # Configure sshd for key-based auth
    && sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Run sshd in foreground
CMD ["/usr/sbin/sshd", "-D"]
