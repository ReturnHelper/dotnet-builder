# returnhelper/dotnet-builder
Docker image for building .net core app on Amazon linux

## Packages available

- dotnet-sdk-3.1
- python3.7
- pip3
- aws

## directories mounting

- /src
- /dist

## example

```bash
docker run  -it --mount type=bind,source="$(pwd)/CoreLib",target=/src returnhelper/dotnet-builder bash
```
