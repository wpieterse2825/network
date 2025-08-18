# Use a base image with a C++ build environment
FROM ubuntu:22.04

# Install necessary tools and libraries
RUN apt-get update && \
    apt-get install -y build-essential cmake ninja-build

# Set the working directory inside the container
WORKDIR /app

# Copy your project's source code into the container
COPY . /app

# Create a build directory and build the project
RUN mkdir out && \
    cd out && \
    cmake -G Ninja .. && \
    cmake --build .
