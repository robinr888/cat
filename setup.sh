#!/bin/bash

set -ex

echo "Retrieving structure-test binary...."
echo
if [[ "$OSTYPE" == "darwin"* ]]; then
    curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-darwin-amd64 \
    && chmod +x container-structure-test-darwin-amd64 && sudo mv container-structure-test-darwin-amd64 /usr/local/bin/container-structure-test
else
    curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64 \
    && chmod +x container-structure-test-linux-amd64 && sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test
fi

export PATH=$PATH:/usr/local/bin
echo
echo "Pulling Google Python Docker image...."
echo

docker pull gcr.io/google-appengine/python