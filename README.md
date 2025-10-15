# Docker vs Podman: Enterprise Decision Guide 🎯

[![Build and Push Container Image](https://github.com/gpm2000/docker-podman-decision-guide/actions/workflows/build-and-push.yml/badge.svg)](https://github.com/gpm2000/docker-podman-decision-guide/actions/workflows/build-and-push.yml)
[![Container Image](https://img.shields.io/badge/container-ghcr.io-blue)](https://github.com/gpm2000/docker-podman-decision-guide/pkgs/container/docker-podman-decision-guide)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive, interactive decision guide comparing Docker and Podman container runtimes for enterprise environments. Designed for CTOs, architects, and technical decision-makers evaluating container platforms for production workloads.

**🆓 100% Free and Open Source** - Uses only free licenses suitable for enterprise production use.

## 🚀 Quick Start (Online Environment)

### Pull from GitHub Container Registry

```bash
# Pull the image
docker pull ghcr.io/gpm2000/docker-podman-decision-guide:latest

# Run the container
docker run -d --name decision-guide -p 8080:80 ghcr.io/gpm2000/docker-podman-decision-guide:latest

# Open in browser
start http://localhost:8080
```

### Or with Podman

```bash
podman pull ghcr.io/gpm2000/docker-podman-decision-guide:latest
podman run -d --name decision-guide -p 8080:80 ghcr.io/gpm2000/docker-podman-decision-guide:latest
```

---

## 🛠️ Development Environment

This section covers local development, building, and testing the decision guide.

**Development Tools (Choose One):**
- **Docker Engine** (Free, Open Source) - Recommended for Linux
- **Podman Desktop** (Free, Open Source) - Recommended for Windows/Mac development

### Prerequisites for Development

- Git
- **Docker Engine** or **Podman Desktop** installed
- Text editor or IDE (VS Code recommended)
- Basic knowledge of HTML/CSS/JavaScript

### Installing Development Tools

#### Option 1: Docker Engine (Linux - Free License)

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Fedora/RHEL
sudo dnf install -y docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Arch Linux
sudo pacman -S docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Log out and back in for group changes to take effect
```

#### Option 2: Podman Desktop (Windows/Mac/Linux - Free License)

```bash
# Windows
# Download from: https://podman-desktop.io/downloads/windows
# Run the installer

# Mac
brew install podman-desktop

# Linux (AppImage)
# Download from: https://podman-desktop.io/downloads/linux
chmod +x podman-desktop-*.AppImage
./podman-desktop-*.AppImage
```

### Clone and Build Locally

```bash
# Clone the repository
git clone https://github.com/gpm2000/docker-podman-decision-guide.git
cd docker-podman-decision-guide

# Build with Docker Engine
docker build -t docker-podman-decision-guide:latest .

# Or build with Podman
podman build -t docker-podman-decision-guide:latest .

# Run locally
docker run -d --name decision-guide -p 8080:80 docker-podman-decision-guide:latest

# Access at http://localhost:8080
```

### Using the Build Script

The project includes an automated build script that detects your container runtime:

```bash
# Make script executable (Linux/Mac)
chmod +x build.sh

# Run the build script
./build.sh

# The script will:
# - Detect Docker or Podman
# - Check for port conflicts
# - Build the image
# - Run the container
# - Verify health status
```

### Using Docker Compose

For easier development workflow:

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and restart
docker-compose up -d --build
```

### Development Workflow

1. **Make Changes** to `src/index.html`
   ```bash
   # Edit the presentation content
   code src/index.html
   ```

2. **Rebuild the Image**
   ```bash
   docker build -t docker-podman-decision-guide:dev .
   ```

3. **Test Locally**
   ```bash
   # Stop old container
   docker stop decision-guide
   docker rm decision-guide
   
   # Run new version
   docker run -d --name decision-guide -p 8080:80 docker-podman-decision-guide:dev
   ```

4. **Verify Changes**
   ```bash
   # Check health
   curl http://localhost:8080/health
   
   # Open in browser
   start http://localhost:8080
   ```

### Live Development (Without Rebuild)

For rapid iteration during development:

```bash
# Mount local src directory as volume
docker run -d --name decision-guide \
  -p 8080:80 \
  -v ${PWD}/src:/usr/share/nginx/html:ro \
  nginx:alpine

# Now edit src/index.html and refresh browser to see changes
# No rebuild needed!
```

### Testing

```bash
# Test with Docker
docker build -t docker-podman-decision-guide:test .
docker run -d --name test-guide -p 8081:80 docker-podman-decision-guide:test

# Run basic tests
curl -f http://localhost:8081/health || echo "Health check failed"
curl -f http://localhost:8081/ || echo "Main page failed"

# Test with different browsers
start http://localhost:8081  # Windows
open http://localhost:8081   # Mac
xdg-open http://localhost:8081  # Linux

# Clean up test container
docker stop test-guide
docker rm test-guide
```

### Multi-Platform Build (Advanced)

```bash
# Setup buildx for multi-platform builds (Docker Engine)
docker buildx create --name multiplatform --use
docker buildx inspect --bootstrap

# Build for multiple platforms
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t docker-podman-decision-guide:latest \
  --load .

# Or push directly to registry
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ghcr.io/gpm2000/docker-podman-decision-guide:latest \
  --push .
```

### Code Quality Checks

```bash
# Validate HTML (requires html-validator)
npm install -g html-validator-cli
html-validator src/index.html

# Check file sizes
ls -lh src/
docker images docker-podman-decision-guide

# Security scan (optional)
docker scan docker-podman-decision-guide:latest
```

### Debugging

```bash
# Run container in interactive mode
docker run -it --rm -p 8080:80 docker-podman-decision-guide:latest sh

# Inside container, you can:
# - Check nginx config: nginx -t
# - View logs: tail -f /var/log/nginx/access.log
# - List files: ls -la /usr/share/nginx/html/

# View container logs
docker logs -f decision-guide

# Execute commands in running container
docker exec -it decision-guide sh
docker exec decision-guide nginx -t
docker exec decision-guide ls -la /usr/share/nginx/html/
```

---

## 🖥️ Production Deployment (Windows 10 Offline)

This section provides complete instructions for deploying in offline Windows 10 production environments using **free and open-source solutions only**.

**Production Options (Choose One):**
- **Docker Engine** (Free, Apache License 2.0) - No Docker Desktop required
- **Podman Engine** (Free, Apache License 2.0) - Daemonless architecture

### Prerequisites for Windows 10 Production

- Windows 10 Pro, Enterprise, or Education (64-bit)
- Hyper-V and Windows Subsystem for Linux (WSL 2) enabled
- Administrator access
- USB drive for transferring files

**⚠️ Important: Docker Desktop is NOT used in production** - We use Docker Engine in WSL 2 or Podman Engine to maintain free licensing.

---

## 📦 Option 1: Docker Engine Installation (Offline Windows 10)

Docker Engine is free and open source (Apache License 2.0). We'll install it inside WSL 2 Ubuntu.

### Step 1: Prepare Installation Files (On Internet-Connected Machine)

```powershell
# Download WSL 2 kernel update
# Visit: https://aka.ms/wsl2kernel
# Save: wsl_update_x64.msi

# Download Ubuntu for WSL
# Visit: https://aka.ms/wslubuntu2004
# Save: Ubuntu_2004.2021.825.0_x64.appx

# Download Docker Engine installation script
# Save docker-install.sh script (see below)

# Copy to USB drive:
# - wsl_update_x64.msi
# - Ubuntu_2004.2021.825.0_x64.appx  
# - docker-install.sh
# - docker-podman-decision-guide.tar
```

Create `docker-install.sh` script:
```bash
#!/bin/bash
# Docker Engine Installation Script for Ubuntu WSL2

# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# Docker Compose (plugin) is now installed and available as 'docker compose'
# To verify:
docker compose version


# Start Docker service
sudo service docker start

# Add current user to docker group
sudo usermod -aG docker $USER

echo "Docker Engine installed successfully!"
echo "Please log out and back in for group changes to take effect."
```

### Step 2: Enable Required Features (On Production Machine)

```powershell
# Run PowerShell as Administrator

# Enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable Virtual Machine Platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Restart computer
Restart-Computer
```

### Step 3: Install WSL 2 Kernel Update (Offline)

```powershell
# Run PowerShell as Administrator

# Install WSL 2 kernel from USB
msiexec /i D:\wsl_update_x64.msi /quiet

# Set WSL 2 as default version
wsl --set-default-version 2

# Verify WSL installation
wsl --status
```

### Step 4: Install Ubuntu Distribution (Offline)

```powershell
# Install Ubuntu from USB
Add-AppxPackage D:\Ubuntu_2004.2021.825.0_x64.appx

# Launch Ubuntu for first-time setup
ubuntu2004.exe

# Set username and password when prompted
# Example: username=admin, password=YourSecurePassword
```

### Step 5: Install Docker Engine in WSL 2 Ubuntu

```bash
# Inside WSL 2 Ubuntu terminal

# Copy installation script from Windows to WSL
cp /mnt/d/docker-install.sh ~/
chmod +x ~/docker-install.sh

# Run installation script
./docker-install.sh

# Log out and back in
exit

# Start Ubuntu again
ubuntu2004.exe

# Verify Docker installation
docker --version
docker info

# Test Docker
docker run hello-world
```

### Step 6: Configure Docker to Start Automatically

```bash
# Inside WSL 2 Ubuntu terminal

# Add to ~/.bashrc or ~/.profile
echo '# Start Docker service if not running' >> ~/.bashrc
echo 'if ! docker info > /dev/null 2>&1; then' >> ~/.bashrc
echo '    sudo service docker start' >> ~/.bashrc
echo 'fi' >> ~/.bashrc

# Reload configuration
source ~/.bashrc
```

---

## 📦 Option 2: Podman Engine Installation (Offline Windows 10)

Podman is free and open source (Apache License 2.0) with no daemon requirement.

### Step 1: Prepare Installation Files (On Internet-Connected Machine)

```powershell
# Download WSL 2 kernel update (if not already downloaded)
# Visit: https://aka.ms/wsl2kernel
# Save: wsl_update_x64.msi

# Download Ubuntu for WSL
# Visit: https://aka.ms/wslubuntu2004  
# Save: Ubuntu_2004.2021.825.0_x64.appx

# Download Podman installation script
# Save podman-install.sh script (see below)

# Copy to USB drive:
# - wsl_update_x64.msi
# - Ubuntu_2004.2021.825.0_x64.appx
# - podman-install.sh
# - docker-podman-decision-guide.tar
```

Create `podman-install.sh` script:
```bash
#!/bin/bash
# Podman Engine Installation Script for Ubuntu WSL2

# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Podman repository
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_20.04/ /" | \
    sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list

# Add repository GPG key
curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_20.04/Release.key | \
    sudo gpg --dearmor -o /etc/apt/keyrings/devel_kubic_libcontainers_stable.gpg

# Install Podman
sudo apt-get update
sudo apt-get install -y podman

echo "Podman Engine installed successfully!"
# Install podman-compose (Python-based, Apache 2.0 license)
sudo curl -L https://raw.githubusercontent.com/containers/podman-compose/devel/podman_compose.py -o /usr/local/bin/podman-compose
sudo chmod +x /usr/local/bin/podman-compose
# To verify:
podman-compose --version

```

### Step 2-4: Enable WSL 2 and Install Ubuntu

Follow the same steps 2-4 from Docker Engine installation above.

### Step 5: Install Podman Engine in WSL 2 Ubuntu

```bash
# Inside WSL 2 Ubuntu terminal

# Copy installation script from Windows to WSL
cp /mnt/d/podman-install.sh ~/
chmod +x ~/podman-install.sh

# Run installation script
./podman-install.sh

# Verify Podman installation
podman --version
podman info

# Test Podman
podman run hello-world
```

---

## 💾 Exporting Image to USB for Offline Deployment

### On Internet-Connected Build Machine

```bash
# Option 1: Export from local build
docker save docker-podman-decision-guide:latest -o docker-podman-decision-guide.tar

# Option 2: Export from GitHub Container Registry
docker pull ghcr.io/gpm2000/docker-podman-decision-guide:latest
docker save ghcr.io/gpm2000/docker-podman-decision-guide:latest -o docker-podman-decision-guide.tar

# Option 3: With Podman
podman save docker-podman-decision-guide:latest -o docker-podman-decision-guide.tar

# Check file size
ls -lh docker-podman-decision-guide.tar
# Should be approximately 25-30MB

# Copy to USB drive
cp docker-podman-decision-guide.tar /media/usb-drive/
```

### Verify Image Integrity

```bash
# Generate checksum for verification
sha256sum docker-podman-decision-guide.tar > docker-podman-decision-guide.tar.sha256

# Copy checksum file to USB
cp docker-podman-decision-guide.tar.sha256 /media/usb-drive/
```

---

## 📥 Loading Image in Production (Offline)

### Copy Files from USB to Production Machine

```powershell
# In PowerShell or Command Prompt

# Copy image file to local directory
Copy-Item D:\docker-podman-decision-guide.tar C:\Temp\

# Verify checksum (optional but recommended)
# Compare with checksum file from USB
Get-FileHash C:\Temp\docker-podman-decision-guide.tar -Algorithm SHA256
```

### Load Image with Docker Engine (in WSL 2)

```bash
# Open WSL 2 Ubuntu terminal
ubuntu2004.exe

# Navigate to Windows directory
cd /mnt/c/Temp

# Load the image with Docker Engine
docker load -i docker-podman-decision-guide.tar

# Verify image is loaded
docker images

# You should see:
# REPOSITORY                        TAG       IMAGE ID       CREATED        SIZE
# docker-podman-decision-guide     latest    xxxxxxxxxxxxx  X hours ago    ~25MB
```

### Load Image with Podman Engine (in WSL 2)

```bash
# Open WSL 2 Ubuntu terminal
ubuntu2004.exe

# Navigate to Windows directory
cd /mnt/c/Temp

# Load the image with Podman Engine
podman load -i docker-podman-decision-guide.tar

# Verify image is loaded
podman images
```

---

## 🚀 Running the Decision Guide in Production

### With Docker Engine (WSL 2)

```bash
# In WSL 2 Ubuntu terminal

# Start Docker service if not running
sudo service docker start

# Run the container
docker run -d --name decision-guide --restart unless-stopped -p 8080:80 docker-podman-decision-guide:latest

# Check container status
docker ps

# View logs
docker logs decision-guide

# Test health endpoint
curl http://localhost:8080/health

# Access from Windows browser
# Open: http://localhost:8080
```

### With Podman Engine (WSL 2)

```bash
# In WSL 2 Ubuntu terminal

# Run the container
podman run -d --name decision-guide --restart unless-stopped -p 8080:80 docker-podman-decision-guide:latest

# Check container status
podman ps

# View logs
podman logs decision-guide

# Access from Windows browser
# Open: http://localhost:8080
```

### Access from Windows

```powershell
# Open browser from Windows
start http://localhost:8080

# Or from command line
curl http://localhost:8080/health
```

---

## 🔧 Production Configuration

### Configure Docker Engine to Start Automatically (WSL 2)

```bash
# In WSL 2 Ubuntu terminal

# Edit your shell profile
nano ~/.bashrc

# Add at the end:
# Start Docker service automatically
if ! docker info > /dev/null 2>&1; then
    sudo service docker start
fi

# Save and reload
source ~/.bashrc

# Alternative: Create systemd service (if systemd is enabled)
sudo systemctl enable docker
```

### Configure Container Auto-Start

```bash
# Containers started with --restart unless-stopped will start automatically
# when Docker/Podman service starts

# Verify restart policy
docker inspect decision-guide | grep RestartPolicy -A 3

# Or with Podman
podman inspect decision-guide | grep RestartPolicy -A 3
```

### Firewall Configuration

```powershell
# Allow inbound traffic on port 8080
New-NetFirewallRule -DisplayName "Decision Guide" `
  -Direction Inbound `
  -LocalPort 8080 `
  -Protocol TCP `
  -Action Allow

# Verify firewall rule
Get-NetFirewallRule -DisplayName "Decision Guide"
```

---

## 📖 Decision Guide Content

This interactive decision guide covers:

1. **Architecture Comparison** - Daemonless vs daemon-based architectures and their implications
2. **Security & Process Management** - Rootless containers, security models, and compliance considerations
3. **Kubernetes Integration** - Native K8s support, pod concepts, and orchestration patterns
4. **Performance Metrics** - Resource overhead, efficiency comparisons, and scalability factors
5. **Monitoring & Operations** - Production operational considerations and tooling ecosystem
6. **Decision Matrix** - Strategic framework for technology selection
7. **Key Takeaways** - Executive summary and recommendations for enterprise adoption

### Target Audience
- **CTOs & VPs of Engineering** - Strategic technology selection
- **Solutions Architects** - Platform design decisions
- **DevOps Leaders** - Tool standardization choices
- **Security Officers** - Compliance and security evaluation
- **Technical Leads** - Team training and adoption planning

### Navigation
- **Keyboard**: Use ← and → arrow keys
- **Mouse**: Click Previous/Next buttons at bottom
- **Progress**: Check slide counter in top-right (e.g., "3/8")

---

## 🛠️ Container Management

### Check Status
```powershell
# Docker
docker ps
docker stats decision-guide
docker logs decision-guide

# Podman
podman ps
podman stats decision-guide
podman logs decision-guide
```

### Health Check
```powershell
curl http://localhost:8080/health
# Should return: "healthy"
```

### Update Container
```powershell
# Stop current container
docker stop decision-guide
docker rm decision-guide

# Load new image from USB
docker load -i docker-podman-decision-guide-v2.tar

# Run updated container
docker run -d --name decision-guide --restart unless-stopped -p 8080:80 docker-podman-decision-guide:latest
```

### Backup and Restore
```powershell
# Backup (export running container)
docker commit decision-guide decision-guide-backup
docker save decision-guide-backup -o decision-guide-backup.tar

# Restore
docker load -i decision-guide-backup.tar
docker run -d --name decision-guide -p 8080:80 decision-guide-backup
```

---

## 🏗️ Project Structure

```
docker-podman-decision-guide/
├── .github/
│   └── workflows/
│       └── build-and-push.yml    # CI/CD pipeline
├── src/
│   └── index.html                # Decision guide content
├── Dockerfile                    # Container definition
├── docker-compose.yml           # Orchestration config
├── nginx.conf                   # Web server config
├── .dockerignore               # Build exclusions
├── .gitignore                  # Git exclusions
├── build.sh                    # Build automation script
├── CONTRIBUTING.md             # Contribution guidelines
├── LICENSE                     # MIT License
└── README.md                   # This file
```

### File Descriptions

- **src/index.html** - Main decision guide HTML with embedded CSS and JavaScript
- **Dockerfile** - Multi-stage build configuration for nginx-alpine base
- **nginx.conf** - Production-ready nginx configuration with security headers
- **docker-compose.yml** - Service orchestration for easy deployment
- **build.sh** - Automated build script with runtime detection
- **.github/workflows/build-and-push.yml** - GitHub Actions CI/CD pipeline

---

## 🧪 Development Best Practices

### Branch Strategy

```bash
# Main branch for production releases
git checkout main

# Create feature branch
git checkout -b feature/your-feature-name

# Create development branch
git checkout -b develop
```

### Making Changes

1. **Edit Content**
   - Update `src/index.html` for presentation changes
   - Modify `Dockerfile` for container changes
   - Update `nginx.conf` for server configuration

2. **Test Locally**
   ```bash
   ./build.sh
   # Verify at http://localhost:8080
   ```

3. **Commit Changes**
   ```bash
   git add .
   git commit -m "feat: Add new comparison metric"
   git push origin feature/your-feature-name
   ```

4. **Create Pull Request**
   - Open PR on GitHub
   - GitHub Actions will automatically build and test
   - Review and merge when tests pass

### Version Tagging

```bash
# Tag a new release
git tag -a v1.1.0 -m "Release version 1.1.0: Added security features"
git push origin v1.1.0

# List all tags
git tag -l

# Delete a tag (if needed)
git tag -d v1.0.0
git push origin --delete v1.0.0
```

---

## 🔍 Troubleshooting

### Docker Engine Issues (WSL 2)

**Docker Service Won't Start**
```bash
# Check Docker service status
sudo service docker status

# Start Docker manually
sudo service docker start

# Check for errors
sudo journalctl -u docker.service -n 50

# Restart Docker
sudo service docker restart
```

**Container Won't Start**
```bash
# Check Docker is running
docker info

# View detailed logs
docker logs decision-guide --tail 100

# Check container status
docker inspect decision-guide

# Remove and recreate
docker stop decision-guide
docker rm decision-guide
docker run -d --name decision-guide --restart unless-stopped -p 8080:80 docker-podman-decision-guide:latest
```

### Podman Engine Issues (WSL 2)

**Podman Command Not Found**
```bash
# Verify Podman installation
which podman
podman --version

# If not installed, run installation script again
./podman-install.sh
```

**Container Won't Start**
```bash
# Check Podman info
podman info

# View detailed logs  
podman logs decision-guide --tail 100

# Check container status
podman inspect decision-guide

# Remove and recreate
podman stop decision-guide
podman rm decision-guide
podman run -d --name decision-guide --restart unless-stopped -p 8080:80 docker-podman-decision-guide:latest
```

**Container Won't Start**
```powershell
# Check Docker service
Get-Service -Name "com.docker.service"
Start-Service -Name "com.docker.service"

# Check Docker Desktop
docker info

# Check system resources
docker system df
```

**Port Already in Use**
```powershell
# Find process using port 8080
netstat -ano | findstr :8080

# Use different port
docker run -d --name decision-guide -p 8081:80 docker-podman-decision-guide:latest
```

**Image Load Fails**
```powershell
# Verify file integrity
Get-FileHash docker-podman-decision-guide.tar -Algorithm SHA256

# Try loading with verbose output
docker load --input docker-podman-decision-guide.tar
```

### Podman Issues

**Podman Machine Won't Start**
```powershell
# Reset Podman machine
podman machine stop
podman machine rm
podman machine init
podman machine start
```

**WSL 2 Issues**
```powershell
# Check WSL status
wsl --list --verbose

# Restart WSL
wsl --shutdown
wsl

# Update WSL
wsl --update
```

### Network Issues

**Cannot Access http://localhost:8080**
```powershell
# Check if container is running
docker ps

# Check container logs
docker logs decision-guide

# Test from command line
curl http://localhost:8080/health

# Check Windows Firewall
Get-NetFirewallRule -DisplayName "Decision Guide"
```

---

## 📊 Container Specifications

- **Base Image**: nginx:alpine
- **Image Size**: ~60MB
- **Memory Usage**: ~10-20MB RAM
- **CPU Usage**: Minimal (static content)
- **Platforms**: linux/amd64, linux/arm64
- **Port**: 80 (maps to 8080 on host)
- **Health Check**: Available at `/health` endpoint
- **Restart Policy**: `unless-stopped` (recommended for production)

---

## 🎯 Use Cases

### For Decision-Makers
- **Strategic Planning** - Framework for container platform selection
- **Risk Assessment** - Security and compliance evaluation
- **Budget Planning** - Cost implications and resource requirements
- **Vendor Evaluation** - Independent comparison without bias

### For Technical Leaders
- **Architecture Design** - Platform design considerations
- **Team Training** - Educational resource for engineering teams
- **Migration Planning** - Transition strategy from Docker to Podman (or vice versa)
- **Standards Definition** - Organizational technology standards

### For DevOps Engineers
- **Technology Evaluation** - Hands-on comparison of features
- **Best Practices** - Production deployment patterns
- **Troubleshooting Guide** - Common issues and solutions
- **Reference Documentation** - Quick lookup for key differences

---

## 🔄 CI/CD Pipeline

This repository uses GitHub Actions to automatically:

1. **Build** the container image on every push to main
2. **Test** multi-platform builds (amd64, arm64)
3. **Push** to GitHub Container Registry (ghcr.io)
4. **Tag** with version numbers, commit SHA, and branch names
5. **Cache** layers for faster subsequent builds

### Available Tags

- `latest` - Latest build from main branch
- `main` - Latest main branch build
- `v*` - Semantic version tags (e.g., v1.0.0)
- `sha-<commit>` - Specific commit builds

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## 📝 License

This project is open source and available under the MIT License.

---

## 🔗 Links

- **GitHub Repository**: https://github.com/gpm2000/docker-podman-decision-guide
- **Container Registry**: https://github.com/gpm2000/docker-podman-decision-guide/pkgs/container/docker-podman-decision-guide
- **Issues**: https://github.com/gpm2000/docker-podman-decision-guide/issues
- **Releases**: https://github.com/gpm2000/docker-podman-decision-guide/releases

---

## 💡 Why This Exists

This decision guide helps enterprises make informed choices about container runtime platforms by providing:
- **Objective Analysis** - Unbiased comparison based on technical facts
- **Real-World Context** - Production considerations and operational impact
- **Strategic Framework** - Decision matrix aligned with business needs
- **Interactive Experience** - Engaging format for executive presentations
- **Offline Capability** - Fully functional without internet connectivity

The guide itself demonstrates the technologies it compares - you can run it with either Docker or Podman to experience both ecosystems firsthand.

---

## 🙏 Acknowledgments

Built with:
- nginx:alpine for lightweight, secure serving
- GitHub Actions for automated CI/CD
- GitHub Container Registry for global distribution

---

**Made for enterprise decision-makers and technical leaders**

*Empowering informed container platform decisions in production environments* 🎯