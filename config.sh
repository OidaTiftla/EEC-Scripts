#!/bin/bash

echo "Setup pdf diff tool"
git_dir=$(git rev-parse --show-toplevel)
git config diff.pdfdiff.command "${git_dir}/pdf-difftool.sh"

echo ""
echo ""
echo "Setup ema textconv"
git_dir=$(git rev-parse --show-toplevel)
git config diff.emadiff.textconv "${git_dir}/ema-textconv.sh"

echo ""
echo ""
echo "Setup zippey"
cp "${git_dir}/zippey.exe" "/c/zippey.exe"
git config filter.zippey.smudge "/c/zippey.exe d"
git config filter.zippey.clean "/c/zippey.exe e"

if ! [ "$(git config filter.zippey.required)" == "true" ]; then
  git config filter.zippey.required true
  echo "Delete and checkout eox to convert it to zip/eox"
  for file in $(git ls-files | sed -r "s/(.*)/\"\1\"/" | xargs git check-attr filter | grep "filter: zippey" | sed -r "s/(.*): filter: zippey/\1/" | sed -r "s/\ /!/"); do
    file=$(echo "$file" | sed -r "s/!/ /")
    echo "Processing ${file}"

    git rm -f "${file}"
    echo "Checkout $file zip/eox style"
    git checkout "${file}"
  done
fi
