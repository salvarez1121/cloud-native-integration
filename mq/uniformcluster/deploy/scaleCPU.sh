#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

oc patch qmgr ucqm1 --patch-file $SCRIPT_DIR/qmgrPatchCPU.yaml -n $TARGET_NAMESPACE --type=merge
sleep 120s
oc patch qmgr ucqm2 --patch-file $SCRIPT_DIR/qmgrPatchCPU.yaml -n $TARGET_NAMESPACE --type=merge
sleep 120s
oc patch qmgr ucqm3 --patch-file $SCRIPT_DIR/qmgrPatchCPU.yaml -n $TARGET_NAMESPACE --type=merge

# Don't worry if the last command fails, some of the resources may have already
# been deleted.
exit 0
