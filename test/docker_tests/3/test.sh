#!/bin/bash

pushd ..
coverage run $(which shutit) build -m ../2 "$@"
