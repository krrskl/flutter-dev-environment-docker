FROM ubuntu:22.04

# Arguments and environment variables
ARG BUILD_TOOLS_VERSION=29.0.2
ARG PLATFORM_VERSION=29
ARG COMMAND_LINE_VERSION=latest

# Installing necessary dependencies
RUN apt update
RUN apt install -y curl git unzip openjdk-8-jdk wget

# Configuring the working directory and user to use
ARG USER=root
USER $USER
WORKDIR /home/$USER

# Prepare environment
ENV ANDROID_HOME Android/sdk
ENV ANDROID_SDK_TOOLS $ANDROID_HOME/tools

# Creating Android directories
RUN mkdir -p $ANDROID_HOME
RUN mkdir -p /root/.android && touch /root/.android/repositories.cfg

# Download Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools $ANDROID_SDK_TOOLS

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git

# Download sdk build tools and platform tools
WORKDIR $ANDROID_SDK_TOOLS/bin
RUN yes | ./sdkmanager --licenses
RUN ./sdkmanager "build-tools;${BUILD_TOOLS_VERSION}" "platform-tools" "platforms;android-${PLATFORM_VERSION}" "sources;android-${PLATFORM_VERSION}"
RUN ./sdkmanager --install "cmdline-tools;${COMMAND_LINE_VERSION}"

# Setup PATH environment variable
ENV PATH $PATH:/home/$USER/$ANDROID_HOME/platform-tools:/home/$USER/flutter/bin

# Verify the status licenses
RUN yes | flutter doctor --android-licenses

# Start the adb daemon
RUN adb start-server