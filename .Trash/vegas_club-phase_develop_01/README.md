# vegas_club

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

run cmd to build app developer : flutter run -t lib/main_dev.dart --flavor dev
run cmd to build app product : flutter run -t lib/main_prod.dart --flavor dev
run cmd to build app apk developer : flutter build apk --flavor dev -t lib/main_dev.dart
run cmd to build app apk product : flutter build apk --flavor prod -t lib/main.dart
run ios release :flutter run -t lib/main.dart --flavor prod --release
GenCode : flutter pub run build_runner build --delete-conflicting-outputs


===================================
add this config to visual code configuration to run

{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "vegas_prod",
            "program": "lib/main_prod.dart",
            "request": "launch",
            "type": "dart",
            "args": [
                "--flavor","prod","-t", "lib/main_prod.dart"
            ],
        },
        {
            "name": "vegas_staging",
            "program": "lib/main_dev.dart",
            "request": "launch",
            "type": "dart",
            "args": [
                 "--flavor","dev", "-t","lib/main_dev.dart"
            ],
        }
    ]
}