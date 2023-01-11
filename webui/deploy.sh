#!/bin/bash

namespace=${1:-"cp4i"}
hostname=`oc get route echo-http -n $namespace -o jsonpath='{.spec.host}' | cut -d "." -f2-`
echo $hostname

cat src/main/java/com/ibm/demo/StartTests.java_template |
  sed "s#{{HOSTNAME}}#$hostname#g;" > src/main/java/com/ibm/demo/StartTests.java

echo "Deploying to $namespace"

oc new-project $namespace
oc project $namespace
oc new-build --name webui --binary --strategy docker
oc start-build webui --from-dir . --follow

cat deployment.yaml_template |
  sed "s#{{NAMESPACE}}#$namespace#g;" > deployment.yaml

oc apply -f deployment.yaml -n $namespace
oc apply -f service.yaml -n $namespace
