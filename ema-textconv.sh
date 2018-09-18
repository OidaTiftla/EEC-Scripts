#!/bin/bash
git_dir=$(git rev-parse --show-toplevel)
# do diff in diff-pdf.exe
echo "List all parameters in macro: regex on *.ema"
echo "============================================"
cat "$1" | "${git_dir}/RegEx.exe" '(?:(?<=A1896\=\"[^\"]*?)[^;\"]+(?=[^\"]*?\")|(?<=@#?&lt;)[^;\"]+?(?=&gt;))' | sort | uniq -c
echo ""
valuesets=$(cat "$1" | "${git_dir}/RegEx.exe" '\<S114x1894\ A2011\=\"(?<valueset>[^\"]+)\"\s+A2012\=\"(?<values>[^\"]+)\"' -f '"${valueset}" => "${values}"' | sort | uniq -c)
echo "List all value sets in macro: regex on *.ema"
echo "============================================"
echo "${valuesets}"
echo ""
echo "List duplicate value sets in macro: regex on *.ema"
echo "============================================"
duplicates=$(echo "${valuesets}" | "${git_dir}/RegEx.exe" '\"(?<valueset>[^\"]*)\" => \"(?<values>[^\"]*)\"' -f '"${values}"' | sort | uniq -c | "${git_dir}/RegEx.exe" '\s+(?<count>\d+)\s+\"(?<values>[^\"]*)\"' -f '${count}x "${values}"' | grep --invert-match '^1x')
while read -r line; do
    count=$(echo "${line}" | "${git_dir}/RegEx.exe" '(?<count>\d+)x\s+\"(?<values>[^\"]*)\"' -f '${count}')
    values=$(echo "${line}" | "${git_dir}/RegEx.exe" '(?<count>\d+)x\s+\"(?<values>[^\"]*)\"' -f '${values}' | sed -e 's/[()&\"]/\\&/g')
    echo "!!! found duplicates for => \"${values}\""
    echo "in:"
    echo "${valuesets}" | grep " => \"${values}\"" | "${git_dir}/RegEx.exe" '\"(?<valueset>[^\"]*)\" => \"(?<values>[^\"]*)\"' -f '    "${valueset}"'
done <<< "${duplicates}"
