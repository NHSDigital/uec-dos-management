#! /bin/bash

# This script runs npm unit tests for the front end

FRONT_END_DIR='src/frontend'

cd $FRONT_END_DIR

# running tests
echo "Running npm unit tests"

npm run test:ci

TEST_RESULTS=$?

if [ $TEST_RESULTS -ne 0 ] ; then
  echo "Npm Unit Tests have failed"
  exit 1
else
  echo "Npm Unit Tests have passed"
  exit 0
fi
