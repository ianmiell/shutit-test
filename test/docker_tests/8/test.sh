#!/bin/bash

pushd ..
coverage $(which shutit) build "$@"
