#!/bin/sh

mkdir --parents ${WORKSPACE_DIR}/docker &&
    ID_FILE=$(mktemp ${WORKSPACE_DIR}/XXXXXXXX) &&
    rm --force ${ID_FILE} &&
    echo ${ID_FILE}