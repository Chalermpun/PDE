# Use the latest official Ubuntu image as the base
FROM ubuntu:jammy

# Set the working directory to /root
WORKDIR /root
RUN apt update

# Copy the contents of the current directory to /root in the container
COPY . .

# Run the setup.sh script using bash
RUN /bin/bash /root/setup.sh
