#!/bin/bash

pushd ..
coverage run --parallel-mode $(which shutit) build "$@"
