# cresce_flutter_app

![Format-Code](https://github.com/AlienEngineer/cresce-flutter-app/workflows/Format-Code/badge.svg)
![Build](https://github.com/AlienEngineer/cresce-flutter-app/actions/workflows/build.yml/badge.svg?branch=master)
![Create-Apk](https://github.com/AlienEngineer/cresce-flutter-app/workflows/Create-Apk/badge.svg)

Cresce flutter app

## Getting Started

```
// Before running integration tests:
docker run -d -p 5000:80 --name cresce.api alienengineer/cresce
```

## Architecture decisions

- Dependency Injection
  - Widgets collect dependencies via `context.get<ServiceType>()`
  - Services receive dependencies via constructor
  - Services are configured via ServiceModule implementation which in turn 
    is registered in the service locator.    
