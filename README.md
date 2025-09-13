# 🐧 Fedora SSH Docker Container

A lightweight, production-ready Fedora container with SSH server enabled. Perfect for development, testing, or as a base for other services.

## ✨ Features

- 🚀 **Latest Fedora** - Based on Fedora latest
- 🔐 **SSH Server** - OpenSSH with secure configuration
- 👥 **Multi-user** - Root and regular user with sudo
- 🛠️ **Essential Tools** - vim, net-tools, iputils included
- 🎯 **Simple** - No systemd complexity, just works

## 🚀 Quick Start

### 1. Build the Image
```bash
docker build -t fedora-sshd .
```

### 2. Run the Container
```bash
docker run -d --name fedora-ssh -p 2222:22 fedora-sshd
```

### 3. Connect via SSH
```bash
# As root user
ssh -p 2222 root@localhost

# As regular user
ssh -p 2222 fedora@localhost
```

**Default Credentials:**
- **root**: `fedora123`
- **fedora**: `fedora123` (with sudo privileges)

## 📋 Container Management

```bash
# View container status
docker ps

# View logs
docker logs fedora-ssh

# Stop container
docker stop fedora-ssh

# Start container
docker start fedora-ssh

# Remove container
docker rm fedora-ssh

# Remove image
docker rmi fedora-sshd
```

## 🔧 Configuration

### SSH Configuration
The container uses a minimal SSH configuration with:
- Port 22 (mapped to host port 2222)
- Password authentication enabled
- Public key authentication enabled
- X11 forwarding enabled
- Root login allowed

### User Management
- **root**: Full system access
- **fedora**: Regular user with sudo privileges (no password required)

## 🛠️ Customization

### Install Additional Packages
Edit the Dockerfile and add packages to the `dnf install` command:
```dockerfile
RUN dnf install -y \
    openssh-server \
    openssh-clients \
    sudo \
    vim \
    net-tools \
    iputils \
    passwd \
    your-package-here \
    && dnf clean all
```

### Change Passwords
Modify the password lines in the Dockerfile:
```dockerfile
RUN echo 'root:your-new-password' | chpasswd
RUN echo 'fedora:your-new-password' | chpasswd
```

### Custom SSH Config
Replace the SSH configuration section in the Dockerfile or mount a custom config file.

## 🔍 Troubleshooting

### Container Won't Start
```bash
# Check if port is in use
lsof -i :2222

# Check container logs
docker logs fedora-ssh

# Run container interactively for debugging
docker run -it fedora-sshd /bin/bash
```

### SSH Connection Issues
```bash
# Test SSH connectivity
telnet localhost 2222

# Check SSH daemon status inside container
docker exec fedora-ssh systemctl status sshd

# View SSH logs
docker exec fedora-ssh journalctl -u sshd
```

### Permission Issues
```bash
# Check container permissions
docker exec fedora-ssh ls -la /var/run/sshd

# Restart SSH service
docker exec fedora-ssh systemctl restart sshd
```

## 📦 What's Included

- **Base**: Fedora latest
- **SSH**: OpenSSH server and client
- **Tools**: vim, net-tools, iputils
- **Users**: root, fedora (with sudo)
- **Services**: SSH daemon only

## 🔒 Security Notes

⚠️ **Important**: This container is configured for development/testing purposes:
- Default passwords are set (change them!)
- Root login is enabled
- Consider hardening for production use

### Production Hardening
1. Change default passwords
2. Disable root login
3. Use SSH keys instead of passwords
4. Configure firewall rules
5. Regular security updates

## 📝 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Feel free to submit issues and enhancement requests!
