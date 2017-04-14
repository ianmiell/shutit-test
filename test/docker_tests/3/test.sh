#!/bin/bash
coverage run --parallel-mode $(which shutit) build -m ../2 "$@"
