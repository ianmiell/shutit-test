#!/bin/bash
pushd ..
coverage run -a $(which shutit) "$@"
