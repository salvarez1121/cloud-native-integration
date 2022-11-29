#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

( echo "cat <<EOF" ; cat addThirdQM.yaml_template ; echo EOF ) | sh > addThirdQM.yaml

oc apply -f addThirdQM.yaml
