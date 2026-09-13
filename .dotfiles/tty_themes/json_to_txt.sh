#!/usr/bin/env bash

set -euo pipefail

for json_file in ./*.json; do
    # Handle the case where no JSON files exist
    [[ -e "$json_file" ]] || continue

    txt_file="${json_file%.json}.txt"

    jq -r '.color[], .foreground, .background' \
        "$json_file" > "$txt_file"

    echo "Converted: $json_file -> $txt_file"
    rm $json_file
done
