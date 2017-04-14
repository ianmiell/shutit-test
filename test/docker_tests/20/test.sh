#!/bin/bash
pushd ..
coverage run --parallel-mode -a $(which shutit) "$@"
