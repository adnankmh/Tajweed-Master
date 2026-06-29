#!/usr/bin/env bash
set -e
flutter pub add firebase_core firebase_auth cloud_firestore firebase_storage google_sign_in
flutter pub add --dev flutterfire_cli || true
echo "Now run: dart pub global activate flutterfire_cli && flutterfire configure"
