# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages and utilities
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    apt-transport-s3 \
    gnupg \
    software-properties-common

# Add your repository
RUN echo "deb [trusted=yes] s3://repo-s3 stable main" >> /etc/apt/sources.list

# Use the secret during build to update repositories and install bat
RUN --mount=type=secret,id=s3auth,target=/etc/apt/s3auth.conf \
    apt-get update && apt-get install -y apt-s3

# Set the default command for the container
CMD ["bash"]