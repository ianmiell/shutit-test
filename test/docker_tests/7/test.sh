#!/bin/bash
coverage run --parallel-mode --include="*shutit*" $(which shutit) build "$@"
