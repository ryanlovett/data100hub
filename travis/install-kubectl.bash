#!/bin/bash

# Install kubectl.

set -euo pipefail

RELEASE=1.8.4
URL="https://storage.googleapis.com/kubernetes-release/release/${RELEASE}/bin/linux/amd64/kubectl"

cd /tmp/
curl -LO ${URL}
sudo install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl
