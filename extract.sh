#!/bin/sh

# ==============================================
# Extract files from the path passed as $1 to path as $2.
# ==============================================

if [ ! -d "${2}" ]; then
    mkdir -p "${2}"
fi

echo "Extracting ${1} to ${2}..."
tar -xf "${1}" -C "${2}"