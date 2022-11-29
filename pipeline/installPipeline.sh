#!/bin/bash

export REPO=
export BRANCH=main
export TARGET_NAMESPACE=${1:-"cp4i"}
export QMGR_NAME_1=ucqm1
export QMGR_NAME_2=ucqm2

( echo "cat <<EOF" ; cat cicd-pipeline.yaml_template ; echo EOF ) | sh > cicd-pipeline.yaml

oc apply -f cicd-pipeline.yaml
