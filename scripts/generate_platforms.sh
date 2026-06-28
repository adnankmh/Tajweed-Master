#!/usr/bin/env bash
set -euo pipefail
flutter create --platforms=android,ios,web,windows,macos,linux .
flutter pub get
