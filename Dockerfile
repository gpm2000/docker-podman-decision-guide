# Use official nginx alpine image for lightweight production
FROM nginx:alpine

# Set maintainer information
LABEL maintainer="gpm2000@gmail.com"
LABEL description="Docker vs Podman Decision Guide - Container Runtime Comparison for Enterprise"
LABEL version="1.0"

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy presentation files to nginx html directory
COPY src/ /usr/share/nginx/html/

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create nginx user if it doesn't exist and set permissions
RUN addgroup -g 101 -S nginx || true && \
    adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx || true && \
    chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]