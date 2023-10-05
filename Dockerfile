# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages and utilities
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    software-properties-common \
    curl

# Download apt-s3 .deb package and install it
RUN curl -Lo /tmp/apt-s3.deb https://github.com/zendesk/apt-s3/releases/download/0.1.5/apt-s3_0.1.5_amd64.deb && \
    dpkg -i /tmp/apt-s3.deb && \
    rm /tmp/apt-s3.deb

# Configure apt to use apt-s3
RUN echo "deb [trusted=yes] s3://devops-intern-33base/myrepo jamny main" > /etc/apt/sources.list.d/s3bucket.list

# Use the secret during build to update repositories and install bat
RUN --mount=type=secret,id=s3auth,target=/etc/apt/s3auth.conf \
    apt-get update && apt-get install -y bat

# Set the default command for the container
CMD ["bash"]

