#!/bin/bash

echo "Setup pdf diff tool"
git_dir=$(git rev-parse --show-toplevel)
git config diff.pdfdiff.command "${git_dir}/pdf-difftool.sh"
