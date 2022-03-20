#!/usr/bin/env bash

# GitHubのリリースページを辿ってpandocコマンドを$HOME/.local/binディレクトリにインストールするスクリプトです。

# コマンドライン引数

# 1st positional argument (amd64かarm64。デフォルトはamd64)
PLATFORM=${1:-amd64}

if [ "${PLATFORM}" != "amd64" -a "${PLATFORM}" != "arm64" ]; then
    echo "unknown platform specified: ${PLATFORM}"
    echo "Only both amd64 and arm64 are allowed."
    exit 1
fi

# 固定値

BASE_RELEASE_URL='https://github.com/jgm/pandoc/releases/'
BASE_RELEASE_TAG_URL="${BASE_RELEASE_URL}tag/"
LATEST_RELEASE_URL="${BASE_RELEASE_URL}latest"

LOG_PATH="/tmp/install-pandoc.log"

echo '# curl' > "${LOG_PATH}"

# locationヘッダーから最新バージョンのリリースページのURLを取得する
# 途中、CRLFのCRが出力に残るためtrコマンドで除去
ACTUAL_RELEASE_URL=`curl --head "${LATEST_RELEASE_URL}" 2>> "${LOG_PATH}" | grep '^location:' |  tr -d '\r' | cut -d' ' -f 2`

echo "actual release path: ${ACTUAL_RELEASE_URL}" | tee -a "${LOG_PATH}"

LATEST_VERSION=`echo "${ACTUAL_RELEASE_URL}" | sed -e "s|${BASE_RELEASE_TAG_URL}||"`

echo "actual latest version: ${LATEST_VERSION}" | tee -a "${LOG_PATH}"

# ダウンロードURLの例: https://github.com/jgm/pandoc/releases/download/2.17.1.1/pandoc-2.17.1.1-linux-amd64.tar.gz
FILE_NAME="pandoc-${LATEST_VERSION}-linux-${PLATFORM}.tar.gz"
DOWNLOAD_URL="${BASE_RELEASE_URL}download/${LATEST_VERSION}/${FILE_NAME}"

echo "download url: ${DOWNLOAD_URL}" | tee -a "${LOG_PATH}"

# /tmpディレクトリにワークディレクトリを用意する
# ワークディレクトリはwgetコマンドが作成する
WORK_DIR="/tmp/pandoc-${LATEST_VERSION}"
DOWNLOAD_PATH="${WORK_DIR}/${FILE_NAME}"

# ファイルをダウンロード
mkdir -p "${WORK_DIR}"
wget --no-verbose "${DOWNLOAD_URL}" -O ${DOWNLOAD_PATH} 2>> "${LOG_PATH}"

WGET_EXIT_CODE=$?
if [ $WGET_EXIT_CODE -ne 0 ]; then
    echo "faield to download ${DOWNLOAD_URL}" | tee -a "${LOG_PATH}"
    echo "see ${LOG_PATH}"
    exit 1
fi

# tar.gzを解凍
tar zxf "${DOWNLOAD_PATH}" -C "$WORK_DIR"

# tar.gzを解凍するとpandoc-${LATEST_VERSION}ディレクトリが作られる
# その配下にはbinディレクトリとshareディレクトリがある
BIN_DIR_PATH="${WORK_DIR}/pandoc-${LATEST_VERSION}/bin"
SHARE_DIR_PATH="${WORK_DIR}/pandoc-${LATEST_VERSION}/share"

# binディレクトリとshareディレクトリを$HOME/.localにコピー
DESTINATION_DIR_PATH="${HOME}/.local"

mkdir -p "${DESTINATION_DIR_PATH}"

echo "copy ${BIN_DIR_PATH} to ${DESTINATION_DIR_PATH}" | tee -a "${LOG_PATH}"
cp -r "${BIN_DIR_PATH}" "${DESTINATION_DIR_PATH}" 2>&1 | tee -a "${LOG_PATH}"

BIN_COPY_EXIT_CODE=$?

echo "copy ${SHARE_DIR_PATH} to ${DESTINATION_DIR_PATH}" | tee -a "${LOG_PATH}"
cp -r "${SHARE_DIR_PATH}" "${DESTINATION_DIR_PATH}" 2>&1 | tee -a "${LOG_PATH}"

SHARE_COPY_EXIT_CODE=$?

if [ $BIN_COPY_EXIT_CODE -eq 0 -a $SHARE_COPY_EXIT_CODE -eq 0 ]; then
    echo "pandoc path: `command -v pandoc`"
    exit 0
else
    echo "failed to copy ${BIN_DIR_PATH} or ${SHARE_DIR_PATH} to ${DESTINATION_PATH}" | tee -a "${LOG_PATH}"
    echo "see ${LOG_PATH}"
    exit 1
fi
