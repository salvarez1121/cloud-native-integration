#!/bin/bash

export REPO=https://github.com/callumpjackson/cloud-native-integration.git
export BRANCH=main
export TARGET_NAMESPACE=${1:-"cp4i"}
export QMGR_NAME_1=ucqm1
export QMGR_NAME_2=ucqm2
export QMGR_NAME_3=ucqm3
export DEFAULT_FILE_STORAGE=cp4i-file-performance-gid

cat cicd-storage.yaml_template |
       sed "s#{{DEFAULT_FILE_STORAGE}}#$DEFAULT_FILE_STORAGE#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" > cicd-storage.yaml

oc apply -f cicd-storage.yaml

cat cicd-pipeline.yaml_template |
       sed "s#{{REPO}}#$REPO#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" |
       sed "s#{{BRANCH}}#$BRANCH#g;" |
       sed "s#{{QMGR_NAME_1}}#$QMGR_NAME_1#g;" |
       sed "s#{{QMGR_NAME_2}}#$QMGR_NAME_2#g;" > cicd-pipeline.yaml

oc apply -f cicd-pipeline.yaml

cat cicd-pipeline-cleanup.yaml_template |
       sed "s#{{REPO}}#$REPO#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" |
       sed "s#{{BRANCH}}#$BRANCH#g;" |
       sed "s#{{QMGR_NAME_1}}#$QMGR_NAME_1#g;" |
       sed "s#{{QMGR_NAME_2}}#$QMGR_NAME_2#g;" > cicd-pipeline-cleanup.yaml

oc apply -f cicd-pipeline-cleanup.yaml

cat cicd-pipeline-scale-core.yaml_template |
       sed "s#{{REPO}}#$REPO#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" |
       sed "s#{{BRANCH}}#$BRANCH#g;" |
       sed "s#{{QMGR_NAME_1}}#$QMGR_NAME_1#g;" |
       sed "s#{{QMGR_NAME_2}}#$QMGR_NAME_2#g;" > cicd-pipeline-scale-core.yaml

oc apply -f cicd-pipeline-scale-core.yaml

cat cicd-pipeline-scale-infinite.yaml_template |
       sed "s#{{REPO}}#$REPO#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" |
       sed "s#{{BRANCH}}#$BRANCH#g;" |
       sed "s#{{QMGR_NAME_1}}#$QMGR_NAME_1#g;" |
       sed "s#{{QMGR_NAME_2}}#$QMGR_NAME_2#g;" > cicd-pipeline-scale-infinite.yaml

oc apply -f cicd-pipeline-scale-infinite.yaml

cat cicd-pipeline-scale-mq.yaml_template |
       sed "s#{{REPO}}#$REPO#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" |
       sed "s#{{BRANCH}}#$BRANCH#g;" |
       sed "s#{{QMGR_NAME_3}}#$QMGR_NAME_3#g;" > cicd-pipeline-scale-mq.yaml

oc apply -f cicd-pipeline-scale-mq.yaml

cat cicd-pipeline-shrink-core.yaml_template |
       sed "s#{{REPO}}#$REPO#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" |
       sed "s#{{BRANCH}}#$BRANCH#g;" |
       sed "s#{{QMGR_NAME_1}}#$QMGR_NAME_1#g;" |
       sed "s#{{QMGR_NAME_2}}#$QMGR_NAME_2#g;" > cicd-pipeline-shrink-core.yaml

oc apply -f cicd-pipeline-shrink-core.yaml

cat cicd-pipeline-shrink-infinite.yaml_template |
       sed "s#{{REPO}}#$REPO#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" |
       sed "s#{{BRANCH}}#$BRANCH#g;" |
       sed "s#{{QMGR_NAME_1}}#$QMGR_NAME_1#g;" |
       sed "s#{{QMGR_NAME_2}}#$QMGR_NAME_2#g;" > cicd-pipeline-shrink-infinite.yaml

oc apply -f cicd-pipeline-shrink-infinite.yaml

cat cicd-pipeline-shrink-mq.yaml_template |
       sed "s#{{REPO}}#$REPO#g;" |
       sed "s#{{NAMESPACE}}#$TARGET_NAMESPACE#g;" |
       sed "s#{{BRANCH}}#$BRANCH#g;" |
       sed "s#{{QMGR_NAME_3}}#$QMGR_NAME_3#g;" > cicd-pipeline-shrink-mq.yaml

oc apply -f cicd-pipeline-shrink-mq.yaml
