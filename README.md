# 🐧 Fedora C/C++ Development Docker Container

A comprehensive Fedora container with SSH server and full C/C++ development environment. Perfect for development, testing, or as a base for C/C++ projects.

## ✨ Features

- 🚀 **Latest Fedora** - Based on Fedora latest
- 🔐 **SSH Server** - OpenSSH with secure configuration
- 👥 **Multi-user** - Root and regular user with sudo
- 🛠️ **C/C++ Development** - GCC, Clang, CMake, debugging tools
- 📦 **Complete Toolchain** - All essential development libraries
- 🎯 **Production Ready** - Optimized for development workflows

## 🚀 Quick Start

### 1. Build the Image
```bash
docker build -t fedora-cpp-dev .
```

### 2. Run the Container
```bash
docker run -d --name my-cpp-dev -p 2222:22 fedora-cpp-dev
```

### 3. Connect via SSH
```bash
# As root user
ssh -p 2222 root@localhost

# As regular user (recommended)
ssh -p 2222 fedora@localhost
```

**Default Credentials:**
- **root**: `fedora123`
- **fedora**: `fedora123` (with sudo privileges)

## 🛠️ Development Tools

### C/C++ Compilers
- **GCC 15.2.1** - GNU C/C++ compiler suite
- **Clang 20.1.8** - LLVM C/C++ compiler
- **GDB 16.3** - GNU debugger
- **LLDB** - LLVM debugger

### Build Systems
- **Make 4.4.1** - Build automation
- **CMake 3.31.6** - Cross-platform build system
- **Ninja 1.12.1** - Fast build system
- **Autotools** - autoconf, automake, libtool

### Development Libraries
- **glibc** - C standard library (dev + static)
- **libstdc++** - C++ standard library (dev + static)
- **zlib** - Compression library
- **OpenSSL** - SSL/TLS library
- **readline** - Command line editing
- **ncurses** - Terminal UI library

### Analysis Tools
- **Valgrind 3.25.1** - Memory debugging and profiling
- **strace** - System call tracer
- **ltrace** - Library call tracer

### Version Control
- **Git 2.51.0** - Version control system

## 📋 Container Management

```bash
# View container status
docker ps

# View logs
docker logs my-cpp-dev

# Stop container
docker stop my-cpp-dev

# Start container
docker start my-cpp-dev

# Remove container
docker rm my-cpp-dev

# Remove image
docker rmi fedora-cpp-dev
```

## 🔧 Usage Examples

### Basic C/C++ Development
```bash
# Connect to container
ssh -p 2222 fedora@localhost

# Create a simple C++ program
cat > hello.cpp << 'EOF'
#include <iostream>
int main() {
    std::cout << "Hello from C++!" << std::endl;
    return 0;
}
EOF

# Compile with GCC
g++ -o hello_gcc hello.cpp
./hello_gcc

# Compile with Clang
clang++ -o hello_clang hello.cpp
./hello_clang
```

### CMake Project
```bash
# Create CMake project
mkdir myproject && cd myproject
cat > CMakeLists.txt << 'EOF'
cmake_minimum_required(VERSION 3.10)
project(MyProject)
add_executable(hello hello.cpp)
EOF

cat > hello.cpp << 'EOF'
#include <iostream>
int main() {
    std::cout << "Hello CMake!" << std::endl;
    return 0;
}
EOF

# Build with CMake
mkdir build && cd build
cmake ..
make
./hello
```

### Debugging with GDB
```bash
# Compile with debug symbols
g++ -g -o debug_test hello.cpp

# Debug with GDB
gdb ./debug_test
# (gdb) run
# (gdb) quit
```

### Memory Debugging with Valgrind
```bash
# Compile program
g++ -g -o mem_test hello.cpp

# Run with Valgrind
valgrind --leak-check=full ./mem_test
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
Connect to the container and install packages:
```bash
ssh -p 2222 fedora@localhost
sudo dnf install -y your-package-here
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
docker logs my-cpp-dev

# Run container interactively for debugging
docker run -it fedora-cpp-dev /bin/bash
```

### SSH Connection Issues
```bash
# Test SSH connectivity
telnet localhost 2222

# Check SSH daemon status inside container
docker exec my-cpp-dev ps aux | grep sshd

# View SSH logs
docker exec my-cpp-dev journalctl -u sshd
```

### Development Issues
```bash
# Check compiler installation
docker exec my-cpp-dev gcc --version
docker exec my-cpp-dev clang --version

# Check available tools
docker exec my-cpp-dev which gdb
docker exec my-cpp-dev which cmake
```

## 📦 What's Included

### Base System
- **OS**: Fedora latest
- **SSH**: OpenSSH server and client
- **Users**: root, fedora (with sudo)

### Development Tools
- **Compilers**: GCC 15.2.1, Clang 20.1.8
- **Debuggers**: GDB 16.3, LLDB
- **Build Systems**: Make 4.4.1, CMake 3.31.6, Ninja 1.12.1
- **Libraries**: glibc, libstdc++, zlib, OpenSSL, readline, ncurses
- **Analysis**: Valgrind 3.25.1, strace, ltrace
- **Version Control**: Git 2.51.0

## 🔒 Security Notes

⚠️ **Important**: This container is configured for development purposes:
- Default passwords are set (change them!)
- Root login is enabled
- Consider hardening for production use

### Production Hardening
1. Change default passwords
2. Disable root login
3. Use SSH keys instead of passwords
4. Configure firewall rules
5. Regular security updates
6. Use non-root user for development

## 📝 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

---

**Happy C/C++ Development! 🚀💻**