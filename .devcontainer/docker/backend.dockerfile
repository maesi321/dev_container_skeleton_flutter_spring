FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# install linux packages
# - basic tools
# - jdk runtime
# - cleanup
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y openjdk-17-jdk maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# fetch project dependencies    
COPY src_backend/pom.xml /tmp/maven/
RUN mvn -f /tmp/maven/pom.xml dependency:go-offline -B && \
    rm -rf /tmp/maven