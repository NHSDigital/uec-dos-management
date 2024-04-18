#!/bin/bash
FRONTEND_DIRECTORY=src/frontend
# Navigate to the frontend directory if it exists
if [ -d "$FRONTEND_DIRECTORY" ]; then
  cd "$FRONTEND_DIRECTORY"  || exit
  # Install node dependencies
  npm ci
else
  echo No frontend source code
fi
