# Flutter Chap App DDD

Flutter project using Domain-Driven Design and bloc pattern

## Getting Started

### Requirements

- Dart: 2.17.6
- Flutter SDK: 3.0.5
- CocoaPods: 1.11.3

### Config

- cp env:
  - Run `cp .env.exampe .env`
  - STREAM_KEY: create projct and get stream key from <https://getstream.io/>
- Gen env to `.vscode/launch.json`:
  - Run  `make dart_defines`
- Firebase config:
  - Create project in here <https://console.firebase.google.com/>
  - Add Firebase to flutter app <https://firebase.google.com/docs/flutter/setup>
  - Enable Authentication and select and adding your first sign-in method is Email/Password Native providers
  - Enable Functions and deploy

### Install

- WARN: If you already and `lefthook` and `lcov`, you could omit this step.

- Install lefthook:
  - Run `gem install lefthook` or  `sudo gem install lefthook`

- Get path:
  - Run `which lefthook`

- Export paths:
  - Add to `.zshrc` or `.bashrc`

```bash
export PATH="$PATH:~/.gem/gems/lefthook-0.7.7/bin"
```

- Save file `.zshrc`
- Run `source ~/.zshrc`

- Install lcov:
  - Run `brew install lcov`
