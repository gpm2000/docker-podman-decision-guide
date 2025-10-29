# Docker vs Podman: Decision Guide 🎯

[![Build and Push Container Image](https://github.com/gpm2000/docker-podman-decision-guide/actions/workflows/build-and-push.yml/badge.svg)](https://github.com/gpm2000/docker-podman-decision-guide/actions/workflows/build-and-push.yml)
[![Container Image](https://img.shields.io/badge/container-ghcr.io-blue)](https://github.com/gpm2000/docker-podman-decision-guide/pkgs/container/docker-podman-decision-guide)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository provides a compact, offline-capable decision guide comparing core Podman and Docker runtime options for development and production.

Goal: give engineers and architects a short, actionable reference for installing and running the guide and for selecting runtime options across common scenarios.

## 🚀 Quick Start (Online Environment)

Pull and run the prebuilt image (Docker):

```bash
docker pull ghcr.io/gpm2000/docker-podman-decision-guide:latest
docker run -d --name decision-guide -p 8080:80 ghcr.io/gpm2000/docker-podman-decision-guide:latest
# Open http://localhost:8080
```

With Podman:

```bash
podman pull ghcr.io/gpm2000/docker-podman-decision-guide:latest
podman run -d --name decision-guide -p 8080:80 ghcr.io/gpm2000/docker-podman-decision-guide:latest
```

## Installing (excluding Desktop editions)

We cover four commonly used runtime scenarios (desktop editions omitted):

- Podman in Ubuntu (WSL) — good for Linux-style workflows on Windows (dev/test). Rootless mode useful for developer safety.
- Docker Engine on Windows (WSL) — when Windows hosts need native Docker workflows or Windows containers (prod/testing via WSL).
- Podman on Linux OS — recommended for production if you want daemonless, rootless operation and systemd integration.
- Docker Engine on Linux OS — recommended for production when you need the mature Docker ecosystem and broad tooling support.

Guidance (dev/test vs production):

- Dev/Test: prefer Podman in WSL or Docker Engine in WSL for quick iteration. Use bind mounts to avoid rebuilding images during changes.
- Production: prefer native Linux hosts. Use Podman on Linux for security-focused deployments; use Docker Engine on Linux when ecosystem/tooling or Windows container support is required.

Quick install examples (Ubuntu / WSL):

Podman (Ubuntu):
```bash
sudo apt-get update
sudo apt-get install -y podman
podman --version
```

Docker Engine (Ubuntu/WSL):
```bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable --now docker
docker --version
```

For Windows WSL workflows, install WSL2 and an Ubuntu distro, then install Podman or Docker Engine inside WSL as above.

## Minimal Development

Clone, build, run:

```bash
git clone https://github.com/gpm2000/docker-podman-decision-guide.git
cd docker-podman-decision-guide
docker build -t docker-podman-decision-guide:dev .
docker run -d --name decision-guide -p 8080:80 docker-podman-decision-guide:dev
# Edit files under src/ and refresh the browser
```

Tip: for rapid iteration mount `./src` into an nginx container during development:

```bash
docker run -d --name decision-guide -p 8080:80 -v ${pwd}/src:/usr/share/nginx/html:ro nginx:alpine
```

## Project structure (source-focused)

```
docker-podman-decision-guide/
├── .github/workflows/   # CI pipeline (build and push)
├── src/                 # Website content
│   ├── index.html                   # Main interactive decision guide
│   ├── podman_docker_compare_guide.html  # Comparison table / printable guide
│   └── compose_comparison.html      # Compose compatibility notes
├── Dockerfile
├── docker-compose.yml
├── nginx.conf
├── build.sh
└── README.md
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


## 🙏 Acknowledgments

Built with:
- nginx:alpine for lightweight, secure serving
- GitHub Actions for automated CI/CD
- GitHub Container Registry for global distribution

---

**Made for enterprise decision-makers and technical leaders**

*Empowering informed container platform decisions in production environments* 🎯
