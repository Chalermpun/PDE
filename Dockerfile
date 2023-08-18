# Use the latest official Ubuntu image as the base
FROM ubuntu:jammy

# Set the working directory to /root
WORKDIR /root

# Update the package list and install any needed dependencies
RUN apt update && apt install -y \
  # List of packages to install goes here \
  && rm -rf /var/lib/apt/lists/*

# Copy the contents of the current directory to /root in the container
COPY . .

# Run the setup.sh script using bash
RUN /bin/bash /root/setup.sh

# Clean up unnecessary files (if needed)
RUN rm -rf /root/Dockerfile /root/README.md /root/init.lua /root/lazy-lock.json /root/lua /root/neovim /root/setup.sh
