# Use lightweight Debian base
FROM ubuntu:20.04

# Install required packages
RUN apt-get update && apt-get install -y \
    cowsay \
    fortune-mod \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Add /usr/games to PATH
ENV PATH="/usr/games:${PATH}"

# Set working directory
WORKDIR /app

# Copy the script into container
COPY wisecow.sh .

# Make it executable
RUN chmod +x wisecow.sh

# Expose the port (same as in wisecow.sh)
EXPOSE 4499

# Run the app
CMD ["./wisecow.sh"]

