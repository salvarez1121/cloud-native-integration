#!/bin/bash

oc delete integrationserver.appconnect.ibm.com echo
oc delete integrationserver.appconnect.ibm.com infinite

# Import kdb and sth files for communication with IBM MQ
oc delete secret mq-key-kdb
oc delete secret mq-key-sth
oc delete secret mq-infinite-ccdt

oc delete configuration mq-uc-key-store.kdb mq-uc-key-store.sth
oc delete configuration mq-infinite-ccdt
oc delete configuration infinite-serverconf
oc delete configuration mq-policy-project

oc delete secret github-creds
oc delete configuration cred-for-github

rm infiniteServerConfig.yaml
rm policyProject.yaml
