#!/usr/bin/env bash
set -euo pipefail
flutter create --platforms=ios .
flutter pub get
flutter analyze
flutter test
flutter build ios --release --no-codesign
