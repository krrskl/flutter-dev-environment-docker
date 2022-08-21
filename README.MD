# Flutter local environment with Docker

This repository is a template for mount a local environment for work with Flutter inside a container.

## Usage and first steps

1. You need installed [Docker](https://www.docker.com/get-started/) in your machine.
2. Clone your flutter project into `/workspace` folder.
3. Open this project in vscode and after select open in container.
4. Enjoi, happy coding!

> In the [NoEMEC](https://www.youtube.com/c/NoEMEC_Dev) channel we will have a video teaching how to use this repository.

## Wireless debugging

### Linux

1. Connect your Android device via USB before to open the dev container.
2. Connect your device via USB and make sure debugging is enabled, then run:

```sh
adb tcpip 5555
```

3. Find the IP address of your device, go to Settings > Wi-Fi > Advanced > IP Address on your device or run `adb shell netcfg`.
4. Connect to device using the IP address with the following command:

```sh
adb connect xxx.xxx.x.x
```

5. Disconnect your device from USB and proceed with wireless debugging.

> Troubleshooting: You can try kill the adb daemon in your host machine using the command `abd kill-server` and then your container should have access to list the device.

### Windows and MacOS

> In these two operating systems it is not possible to share your USB device with the container, that is why we must resort to an alternative way.

First you will have to have the platforms tools that contain ADB installed on your host machine and you can download them [here](https://developer.android.com/studio/releases/platform-tools#downloads)

1. Connect your device via USB and make sure debugging is enabled, then run in your host machine:

```sh
adb tcpip 5555
```

2. Find the IP address of your device, go to Settings > Wi-Fi > Advanced > IP Address on your device or run `adb shell netcfg`.
3. Connect to device using the IP address with the following command:

```sh
adb connect xxx.xxx.x.x
```

4. Disconnect USB and proceed to open the dev container in vscode.
5. Now inside your container run the command from step 3 with the same IP address.
6. Verify if the container can list now your device using `adb devices`.

## Features

- Android Sdk
- Flutter
- Git
- ADB

## Contributing

Contributions are always welcome!

## Sources

- [Developing inside a Container Vscode](https://code.visualstudio.com/docs/remote/containers#_getting-started)
- [Enable adb debugging on your device](https://developer.android.com/studio/command-line/adb#Enabling)
