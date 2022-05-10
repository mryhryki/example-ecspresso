#!/usr/bin/env bash
THIS_DIR="$(cd "$(dirname "${BASH_SOURCE}")"; pwd)"

ecspresso deploy \
    --envfile="${THIS_DIR}/.env" \
    --config="${THIS_DIR}/ecspresso.yml"
