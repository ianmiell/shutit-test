#!/bin/bash

pushd ..
coverage run shutit build "$@"
