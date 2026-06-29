#!/usr/bin/env bash
set -e
firebase target:apply hosting admin tajweed-master-admin
firebase deploy --only hosting:admin
