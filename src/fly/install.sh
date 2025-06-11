#!/bin/bash -i

set -e

source ./library_scripts.sh

ensure_nanolayer nanolayer_location "v0.5.4"

if [[ 'none' == $CONCOURSEURL ]]; then

    $nanolayer_location \
        install \
        devcontainer-feature \
        "ghcr.io/devcontainers-extra/features/gh-release:1.0.25" \
        --option repo='concourse/concourse' --option binaryNames='fly' --option version="$VERSION" --option assetRegex="fly.+-linux-.+\.tgz$"

else

    if [ "$OS" = "Windows_NT" ]; then
        platform="windows"
        arch="amd64"
    else
        case $(uname -sm) in
        "Darwin x86_64") 
            platform="darwin"
            arch="amd64"
            ;;
        "Darwin arm64") 
            echo "Error: This architecture is not supported by Concourse downloads." 1>&2
            exit 1
            ;;
        "Linux aarch64")
            echo "Error: This architecture is not supported by Concourse downloads." 1>&2
            exit 1
            ;;
        *)
            platform="linux"
            arch="amd64"
            ;;
        esac
    fi

    $nanolayer_location \
        install \
        devcontainer-feature \
        'ghcr.io/devcontainers-extra/features/curl-apt-get:1'

    DEFAULT_BIN_LOCATION="/usr/local/bin"

    echo "${CONCOURSEURL}/api/v1/cli?arch=${arch}&platform=${platform}"
    curl -kL -o "${DEFAULT_BIN_LOCATION}/fly" "${CONCOURSEURL}/api/v1/cli?arch=${arch}&platform=${platform}"
    chmod +x ${DEFAULT_BIN_LOCATION}/fly
fi

echo 'Done!'