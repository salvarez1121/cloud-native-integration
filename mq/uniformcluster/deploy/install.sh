#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export TARGET_NAMESPACE=${1:-"cp4i"}

( echo "cat <<EOF" ; cat $SCRIPT_DIR/uniformcluster.yaml_template ; echo EOF ) | sh > $SCRIPT_DIR/uniformcluster.yaml

oc apply -f $SCRIPT_DIR/uniformcluster.yaml
