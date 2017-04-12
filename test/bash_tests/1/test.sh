#!/bin/bash
pushd ..
coverage run shutit -d bash "$@"
