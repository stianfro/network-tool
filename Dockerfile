# Use Alpine as base image
FROM alpine:3.23@sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375

# Install required packages
RUN apk add --no-cache tcpdump arping python3 curl iputils-tracepath traceroute net-tools iproute2 bind-tools netcat-openbsd

# Create unprivileged user with uid > 1000
RUN adduser -D -u 2000 nonrootuser

# Set working directory
WORKDIR /home/nonrootuser

# Copy index.html to the working directory
COPY index.html .

# Switch to nonrootuser
USER nonrootuser

# Expose port 8080 for the webserver
EXPOSE 8080

# Command to run simple HTTP server on port 8080
CMD ["python3", "-m", "http.server", "--bind", "::", "8080"]
