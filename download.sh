#!/bin/sh

# ==============================================
# Downloads file from the URL passed as $1 and saves it to path as $2.
# ==============================================

DOWNLOAD_URL="${1}"
DOWNLOAD_PATH="${2}.download"
FINAL_PATH="${2}"

if [ ! -f "${DOWNLOAD_PATH}" ]; then
    if [ ! -d `dirname "${DOWNLOAD_PATH}"` ]; then
        mkdir -p `dirname "${DOWNLOAD_PATH}"`
    fi
    echo "Downloading ${DOWNLOAD_URL}..."
    curl -L -# -o ${DOWNLOAD_PATH} "${DOWNLOAD_URL}"
fi

cp "${DOWNLOAD_PATH}" "${FINAL_PATH}"

rm -rf ${DOWNLOAD_PATH}