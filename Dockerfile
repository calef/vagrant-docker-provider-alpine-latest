FROM alpine:latest
LABEL MAINTAINER="Chris Alef <chris@crickertech.com>"

# Install SSH, sudo and bash
RUN apk add --no-cache openssh sudo bash shadow

# Create the vagrant user
RUN addgroup -S vagrant \
    && adduser -D -s /bin/bash -G vagrant vagrant \
    && echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant \
    && chmod 0440 /etc/sudoers.d/vagrant \
    && mkdir -p /home/vagrant/.ssh \
    && chown -R vagrant:vagrant /home/vagrant/.ssh \
    && ssh-keygen -A

# Expose SSH
EXPOSE 22

# Run sshd in foreground
CMD ["/usr/sbin/sshd","-D"]
