#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#Deploy echo Integration Server
oc apply -f $SCRIPT_DIR/resources/echoIntegrationServer.yaml
