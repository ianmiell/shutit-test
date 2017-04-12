#!/bin/bash

pushd ..
coverage run $(which shutit) build "$@"
