FROM ubuntu:latest

# Install necessary packages and utilities
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    apt-transport-s3 \
    gnupg \
    software-properties-common \
    curl

# Copy the s3auth.conf file into the container
COPY s3auth.conf /etc/apt/s3auth.conf

# Add your repository
RUN echo "deb [trusted=yes] s3://devops-intern-33base/myrepo jamny main" >> /etc/apt/sources.list

# Update repositories and install bat
RUN apt-get update && apt-get install -y bat

# Set the default command for the container
CMD ["bash"] 