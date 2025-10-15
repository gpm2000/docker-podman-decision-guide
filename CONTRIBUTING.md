# Contributing to Docker vs Podman Enterprise Decision Guide

Thank you for considering contributing to this project! 

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Your environment (OS, Docker/Podman version)

### Suggesting Enhancements

We welcome suggestions for:
- Additional comparison points for decision-makers
- Visual improvements for executive presentations
- New decision frameworks or metrics
- Performance optimizations
- Enhanced documentation

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Update presentation content in `src/index.html`
   - Modify container config if needed
   - Update documentation

4. **Test locally**
   ```bash
   ./build.sh
   # Verify at http://localhost:8080
   ```

5. **Commit with clear messages**
   ```bash
   git commit -m "Add: Brief description of changes"
   ```

6. **Push and create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

## Development Guidelines

### Code Style
- Use consistent indentation (2 spaces)
- Keep HTML semantic and accessible
- Comment complex CSS/JavaScript

### Testing
- Test with both Docker and Podman
- Verify on different browsers
- Check mobile responsiveness
- Ensure all slides render correctly

### Decision Guide Content
- Keep comparisons factual and unbiased
- Cite sources for technical claims
- Maintain professional, executive-appropriate tone
- Use consistent formatting
- Focus on strategic decision-making factors
- Include both technical and business perspectives

## Building and Testing

```bash
# Build the image
docker build -t docker-podman-decision-guide:test .

# Run locally
docker run -d --name test-guide -p 8081:80 docker-podman-decision-guide:test

# Test health endpoint
curl http://localhost:8081/health

# View in browser
open http://localhost:8081

# Clean up
docker stop test-guide
docker rm test-guide
```

## Questions?

Feel free to open an issue for any questions about contributing!