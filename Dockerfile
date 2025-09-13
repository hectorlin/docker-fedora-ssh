# Simple Fedora container with SSH server
FROM fedora:latest

# Install SSH server and basic tools
RUN dnf update -y && \
    dnf install -y \
    openssh-server \
    openssh-clients \
    sudo \
    vim \
    net-tools \
    iputils \
    passwd \
    && dnf clean all

# Create SSH directory
RUN mkdir -p /var/run/sshd

# Configure SSH daemon
RUN echo 'Port 22' > /etc/ssh/sshd_config && \
    echo 'Protocol 2' >> /etc/ssh/sshd_config && \
    echo 'HostKey /etc/ssh/ssh_host_rsa_key' >> /etc/ssh/sshd_config && \
    echo 'HostKey /etc/ssh/ssh_host_ecdsa_key' >> /etc/ssh/sshd_config && \
    echo 'HostKey /etc/ssh/ssh_host_ed25519_key' >> /etc/ssh/sshd_config && \
    echo 'UsePrivilegeSeparation yes' >> /etc/ssh/sshd_config && \
    echo 'LoginGraceTime 120' >> /etc/ssh/sshd_config && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'StrictModes yes' >> /etc/ssh/sshd_config && \
    echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'IgnoreRhosts yes' >> /etc/ssh/sshd_config && \
    echo 'PermitEmptyPasswords no' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'X11Forwarding yes' >> /etc/ssh/sshd_config && \
    echo 'PrintMotd no' >> /etc/ssh/sshd_config && \
    echo 'PrintLastLog yes' >> /etc/ssh/sshd_config && \
    echo 'TCPKeepAlive yes' >> /etc/ssh/sshd_config && \
    echo 'AcceptEnv LANG LC_*' >> /etc/ssh/sshd_config && \
    echo 'Subsystem sftp /usr/libexec/openssh/sftp-server' >> /etc/ssh/sshd_config

# Generate SSH host keys
RUN ssh-keygen -A

# Set root password
RUN echo 'root:fedora123' | chpasswd

# Create a regular user with sudo privileges
RUN useradd -m -s /bin/bash fedora && \
    echo 'fedora:fedora123' | chpasswd && \
    usermod -aG wheel fedora && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Expose SSH port
EXPOSE 22

# Start SSH daemon in foreground
CMD ["/usr/sbin/sshd", "-D"]
