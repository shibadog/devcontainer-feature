#!/bin/bash -i

set -e

source ./library_scripts.sh

ensure_nanolayer nanolayer_location "v0.5.4"

$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-extra/features/gh-release:1.0.25" \
    --option repo='carvel-dev/ytt' --option binaryNames='ytt' --option version="$VERSION"

echo 'Done!'