#!/bin/bash

echo "Setup ema textconv"
git_dir=$(git rev-parse --show-toplevel)
git config diff.emadiff.textconv "${git_dir}/ema-textconv.sh"
