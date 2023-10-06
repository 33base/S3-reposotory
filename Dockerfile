# Use the official Ubuntu image
FROM ubuntu:latest


# Update the package list
RUN apt-get update

# Add your S3 bucket to the APT repository list
RUN echo "deb [trusted=yes] http://repo-s3.s3.eu-central-1.amazonaws.com/ stable main" | tee -a /etc/apt/sources.list > /dev/null

# Update the package list again to see packages from your S3 bucket
RUN apt-get update

# Install the apt-s3 package
RUN apt-get install -y apt-s3

CMD ["sleep", "infinity"]
