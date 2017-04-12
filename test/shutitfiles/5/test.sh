#!/bin/bash
set -e
set -x
rm -rf /tmp/asd
coverage run $(which shutit) skeleton --name /tmp/asd --pattern shutitfile --delivery docker
pushd /tmp/asd
./run.sh "$@"
popd
