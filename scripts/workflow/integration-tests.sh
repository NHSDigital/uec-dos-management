#! /bin/bash

# fail on first error
set -e
# This script runs python integration tests
#
export APPLICATION_TEST_DIR="${APPLICATION_TEST_DIR:-"tests/integration"}"

# check export has been done
EXPORTS_SET=0
if [ -z "$WORKSPACE" ] ; then
  echo Set WORKSPACE to the workspace to action the terraform in
  EXPORTS_SET=1
fi

if [ -z "$APPLICATION_TEST_DIR" ] ; then
  echo Set APPLICATION_TEST_DIR to directory holding int test code
  EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more exports not set
  exit 1
fi

echo "Installing requirements"
pip install -r "$APPLICATION_TEST_DIR"/requirements.txt

echo "Running integration tests under $APPLICATION_TEST_DIR for workspace $WORKSPACE"
cd $APPLICATION_TEST_DIR || exit
behave --tags=pipeline_tests -D workspace=$WORKSPACE --format=allure -o allure-results;

echo "Generating allure report"
allure generate --single-file -c -o  allure-reports;
