# Dev container skeleton with Flutter and Spring
A skeleton project for the development of Flutter frontend and Spring backend with VS Code Dev Container.

## Motivation
The motivation for this project was to learn about VS Code Dev Container, Flutter and Docker. Maybe it will help someone as a stepping stone for their own project.

This project is far from being production ready. It lacks things like .env files, authentication, security, etc. There is also a lot of room for improvement in terms of performance.

## Resources
- [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)
- [Docker-compose reference](https://docs.docker.com/reference/compose-file/)
- [VS Code dev container reference](https://code.visualstudio.com/docs/devcontainers/containers)
- Flutter setup
    - [Developing Flutter Applications Inside a DevContainer](https://blog.devops.dev/developing-flutter-applications-inside-a-devcontainer-4b13de5369e2)
    - [How to Install Android SDK and Command-Line Tools on Ubuntu Without Android Studio](https://thanhtunguet.info/posts/android-sdk-without-android-studio/)
    - [Android SDK command line tools only](https://dev.to/mesaquen/android-sdk-command-line-tools-only-4g6e)
    - [Connecting to Devices Inside DevContainers](https://medium.com/@sinancsoysal/connecting-to-devices-inside-devcontainers-9a4ec7e55f38)
    - ... and a lot more

## Other skeletons
- [React and FastAPI](https://github.com/maesi321/dev_container_skeleton_react_fastapi)

## Mental model
The repo is a mono-repo and consists of following parts:
- src_backend: complete backend service with code and resources
- src_frontend: complete frontend service with code and resources
- .devcontainer: defintion of dev-container and docker-compose
- docs: space for project documentation (general, frontend, backend, etc)

The code is mounted via volume into the container. The container itself provides a development environment with the required dependencies installed. 
When the dev container is started via VS Code the service itself needs to be started manually, the container self runs infinitly as long as IDE is running.

## Setup
- Docker installed -> [Docker homepage](https://www.docker.com/get-started/)
- (optional) grant Docker more resources to enable smooth development
- VS Code installed -> [VS Code homepage](https://code.visualstudio.com/)
- VS Code extension "Dev Containers" installed -> [Marketplace page](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- downloaded or cloned this repo

## How to start
- open this repo in VS Code
- run "Dev Containers: Rebuild and Reopen in Container"
![example what to run](/docs/assets/image.png)
- the first opening takes a few minutes
- happy coding (the service working on needs to be started manually)

### Backend
- inside the dev-container the backend service can be started with ```mvn spring-boot:run```

### Frontend
- inside the dev-container the frontend service can be started with ```flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0``` or via VS Code run-configs

The usage of Android emulation is also possible. For this the emulator is running on the host machine (bare metal). From within the container a connection via [ADB](https://developer.android.com/tools/adb) is possible.
- install an android emulator
    - also possible via command lines tools only (sdkmanager, abdmanager, etc)
    - recommended is via Android studio (easy of use)
- start android emulator
- execute on host ```adb tcpip 5555``` to let emulator listen on port 5555
- execute on container ```adb connect host.docker.internal:5555```
- start flutter run-config for android app developement, the app should now be visible on the host machine
