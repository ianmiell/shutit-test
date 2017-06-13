#!/bin/bash
coverage run --parallel-mode --include="*shutit*" $(which shutit) build -m ../2 -d docker "$@"
