#!/bin/bash
git_dir=$(git rev-parse --show-toplevel)
temp=$(basename $2)
# create temp file
cp "$2" "${git_dir}/$temp"
# do diff in diff-pdf.exe
echo "${git_dir}/tests/diff-pdf/diff-pdf.exe" --view "$1" "${git_dir}/$temp"
"${git_dir}/tests/diff-pdf/diff-pdf.exe" --view "$1" "${git_dir}/$temp"
# remove temp file
rm "${git_dir}/$temp"
