#!/bin/bash -i

set -e

source ./library_scripts.sh

ensure_nanolayer nanolayer_location "v0.5.4"

$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/meaningful-ooo/devcontainer-features/homebrew:2.0.4" \
    --option shallow_clone='true' --option update="ture"
source /etc/profile.d/nanolayer-homebrew.sh

su - "$_REMOTE_USER" <<EOF
    brew install cloudfoundry/tap/cf-cli@${VERSION}
EOF

echo 'Done!'