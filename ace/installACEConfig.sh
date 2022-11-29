#!/bin/bash

# Import kdb and sth files for communication with IBM MQ
rm configuration
cp ../mq/uniformcluster/test/key.kdb configuration
oc create secret generic mq-key-kdb --from-file=configuration
rm configuration
cp ../mq/uniformcluster/test/key.sth configuration
oc create secret generic mq-key-sth --from-file=configuration
oc apply -f resources/mqKeyStore.yaml
rm configuration

#Deploy authentication policy for bar file retrieval from githubusercontent
cp resources/GitHubCredentials configuration
oc create secret generic github-creds --from-file=configuration
oc apply -f resources/credentialsForGitHub.yaml
rm configuration

# Create CCDT configuration
export ROOTURL="$(oc get IngressController default -n openshift-ingress-operator -o jsonpath='{.status.domain}')"
( echo "cat <<EOF" ; cat resources/ccdt_template.json ; echo EOF ) | sh > ccdt.json
zip configuration.zip ccdt.json
mv configuration.zip configuration
oc create secret generic mq-infinite-ccdt --from-file=configuration
oc apply -f resources/ccdt.yaml
rm configuration ccdt.json

# Create MQ Policy Project
export POLICY_PROJECT=`cat bars/InfiniteScalePolicyProject.bar | base64 -w10000`
( echo "cat <<EOF" ; cat resources/policyProject.yaml_template ; echo EOF ) | sh > policyProject.yaml
oc apply -f policyProject.yaml

#Deploy integration server configuration
export SERVER_CONFIG=`cat resources/server.conf.yaml | base64 -w10000`
( echo "cat <<EOF" ; cat resources/infiniteServerConfig.yaml_template ; echo EOF ) | sh > infiniteServerConfig.yaml
oc apply -f infiniteServerConfig.yaml
