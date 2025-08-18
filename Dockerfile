# Stage 1: Build Environment
# Use a C++ builder image with CMake and a compiler
FROM alpine:latest AS build

# Install build dependencies
RUN apk add --no-cache g++ cmake make

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Configure and build the application using CMake
RUN mkdir -p out
RUN cd out && cmake -DCMAKE_BUILD_TYPE=Release ..
RUN cd out && make

# Stage 2: Final Runtime Environment
# Use a minimal Alpine image for the final container
FROM alpine:latest

# Install the C++ standard library runtime
RUN apk add --no-cache libstdc++

# Set the working directory
WORKDIR /app

# Copy the compiled executable from the 'build' stage
COPY --from=build /app/out/hello /app/hello

# Expose the UDP port for network interactions
EXPOSE 8080/udp

# Command to run the application
CMD ["./hello"]