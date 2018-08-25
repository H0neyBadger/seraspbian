#!/bin/bash

set -euxo pipefail
container="seraspbian:latest"

pushd ./docker
docker build \
    --build-arg OWNER_UID="${SUDO_UID}" \
    --build-arg OWNER_GID="${SUDO_GID}" \
    -t "$container" .
popd

docker run --rm -v $(pwd):/build/ --workdir=/build/ --entrypoint ./run.sh "$container"
