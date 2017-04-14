#!/bin/bash
pushd ..
coverage run --parallel-mode $(which shutit) -d bash "$@"
