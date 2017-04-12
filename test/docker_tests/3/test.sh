#!/bin/bash

pushd ..
coverage run shutit build -m ../2 "$@"
