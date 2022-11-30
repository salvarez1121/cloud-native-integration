#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR

( echo "cat <<EOF" ; cat addThirdQM.yaml_template ; echo EOF ) | sh > addThirdQM.yaml

oc apply -f addThirdQM.yaml
