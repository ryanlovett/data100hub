#!/bin/bash

# Install kubectl.

set -euo pipefail

RELEASE=1.8.4
URL="https://storage.googleapis.com/kubernetes-release/release/${RELEASE}/bin/linux/amd64/kubectl"
DEST=/usr/local/bin/kubectl

curl -L -o ${DEST} ${URL}
chmod +x ${DEST}
