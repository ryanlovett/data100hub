#!/bin/bash

# Install helm.

set -euo pipefail

URL="https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get"

curl ${URL} | sudo bash
