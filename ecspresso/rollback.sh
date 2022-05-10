#!/usr/bin/env bash
THIS_DIR="$(cd "$(dirname "${BASH_SOURCE}")"; pwd)"

ecspresso rollback \
    --config="${THIS_DIR}/ecspresso.yml" \
    --envfile="${THIS_DIR}/.env" \
    --deregister-task-definition # 今後、間違ってロールバックしたタスク定義を使われないように現行のリビジョンをINACTIVEにする
