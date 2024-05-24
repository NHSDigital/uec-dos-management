#!/bin/bash
export SHA="${SHA:-""}"
echo Not used
# COMMIT_HASH="Unknown"
# # check exports have been done
# EXPORTS_SET=0
# # Check key variables have been exported - see above
# if [ -z "$SHA" ] ; then
#   echo Set SHA to required sha for commit on required branch
#   EXPORTS_SET=1
# fi

# if [ $EXPORTS_SET = 1 ] ; then
#   echo One or more exports not set
#   exit 1
# fi

# COMMIT_HASH=$(git rev-parse --short "$SHA")

# export COMMIT_HASH
