#!/bin/bash
# FRONTEND_DIRECTORY=src/backend
# FRONT_END_DIR='src/frontend'
export FRONT_END_DIR="${FRONT_END_DIR:-"src/frontend"}"
# Navigate to the frontend directory if it exists
if [ -d "$FRONTEND_DIRECTORY" ]; then
  cd "$FRONTEND_DIRECTORY"  || exit
  # Run the linter #
  npm run lint
else
  echo No code to lint
fi

