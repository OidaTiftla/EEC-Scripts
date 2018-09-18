#!/bin/bash

# copy files locally
cp .gitattributes /c/.gitattributes
cp zippey.exe /c/zippey.exe
cp zippey.py /c/zippey.py
cp convert.sh /c/convert.sh

# do filter in git
git filter-branch --prune-empty --tree-filter '
echo ""
git config filter.zippey.smudge "/c/zippey.exe d"
git config filter.zippey.clean "/c/zippey.exe e"
git config filter.zippey.required true
cp /c/.gitattributes .gitattributes
cp /c/zippey.exe zippey.exe
cp /c/zippey.py zippey.py
cp /c/convert.sh convert.sh
git add .gitattributes zippey.exe zippey.py convert.sh

for file in $(git ls-files | sed -r "s/(.*)/\"\1\"/" | xargs git check-attr filter | grep "filter: zippey" | sed -r "s/(.*): filter: zippey/\1/" | sed -r "s/\ /!/"); do
  file=$(echo "$file" | sed -r "s/!/ /")
  echo "Processing ${file}"

  git rm -f --cached "${file}"
  echo "Adding $file txt style"
  git add "${file}"
done' --tag-name-filter cat -- --all | tee /c/convert.log | grep 'Rewrite\|fatal'