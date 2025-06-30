FROM ubuntu:24.04

# deactivate interaction with terminal
ENV DEBIAN_FRONTEND=noninteractive

# install linux packages
# - basic tools
# - tools to download and unzip files
# - dependencies for flutter -> see "flutter doctor"
RUN apt-get update -y && apt-get upgrade -y && \ 
    apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    zip \
    xz-utils \
    libglu1-mesa \
    openjdk-17-jdk \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev

# create a temp folder to download and unzip and a sdk folder    
RUN mkdir -p /tmp/android && \
    mkdir -p /opt/android

# download and install android sdk
# download page: https://developer.android.com/studio#command-tools
# - download to temp folder
# - unzip file
# - rename folder structure to comply with android specifications
# - move files to sdk folder
RUN wget \
    https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip \
    -O /tmp/android/android_cmd_tools.zip && \
    unzip /tmp/android/android_cmd_tools.zip -d /tmp/android && \
    mkdir -p /opt/android/cmdline-tools/latest && \
    mv /tmp/android/cmdline-tools/* /opt/android/cmdline-tools/latest

# download and install flutter
# - download to temp folder
# - unpack file
# - move files to sdk folder
# - mark folder as trusted
RUN wget \
https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.32.3-stable.tar.xz \
    -O /tmp/android/flutter.tar.xz && \
    tar -xf /tmp/android/flutter.tar.xz -C /tmp/android && \
    mv /tmp/android/flutter /opt/android
RUN git config --global --add safe.directory /opt/android/flutter

# cleanup temp folder
RUN rm -rf /tmp/android

# add paths for executables
ENV PATH=${PATH}:\
/opt/android/cmdline-tools/latest/bin:\
/opt/android/platform-tools:\
/opt/android/flutter/bin

# set env-variables
ENV ANDROID_HOME=/opt/android \
    ANDROID_SDK_ROOT=/opt/android

# setup android build pipeline
# android emulation is done on bare metal
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" && \ 
    sdkmanager "platforms;android-30" && \ 
    sdkmanager "build-tools;30.0.3"

# setup flutter sdk environment
RUN flutter config --no-analytics

# fetch project dependencies
COPY src_frontend/pubspec.yaml /tmp/flutter/
RUN cd /tmp/flutter && \
    flutter pub upgrade && \
    rm -rf /tmp/flutter