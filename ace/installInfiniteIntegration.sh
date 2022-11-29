#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

oc apply -f $SCRIPT_DIR/resources/infiniteIntegrationServer.yaml
