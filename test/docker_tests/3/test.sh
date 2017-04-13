#!/bin/bash

pushd ..
coverage run -a $(which shutit) build -m ../2 "$@"
