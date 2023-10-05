# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages and utilities
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    gnupg \
    software-properties-common \
    curl \
    git \
    golang-go

# Clone and build apt-s3
RUN git clone https://github.com/zendesk/apt-s3.git /tmp/apt-s3 && \
    cd /tmp/apt-s3 && \
    make && \
    cp apt-s3 /usr/bin/

# Add your repository
RUN echo "deb [trusted=yes] s3://devops-intern-33base/myrepo jamny main" >> /etc/apt/sources.list

# Use the secret during build to update repositories and install bat
RUN --mount=type=secret,id=s3auth,target=/etc/apt/s3auth.conf \
    apt-get update && apt-get install -y bat

# Set the default command for the container
CMD ["bash"]
