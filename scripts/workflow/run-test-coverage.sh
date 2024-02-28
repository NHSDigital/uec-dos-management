#! /bin/bash

# fail on first error
set -e
# This script runs python unit tests and produces coverage report
#
APPLICATION_DIR=application
APPLICATION_UTIL_DIR=application-utils

# cleardown cache from previous run needs
rm -f .coverage
echo "Precautionary removal of temporary files"
for path in "$APPLICATION_DIR"/*/ ; do
    dirs=$(echo "$path" | tr "\/" '\n')
    for dir in $dirs
        do
            if [ -d $APPLICATION_DIR/"$dir"/test/ ]; then
                echo "Clearing down temp test files for $dir"
                rm -rf $APPLICATION_DIR/"$dir"/common
            fi
        done
done

# if command line argument provided use that to target specific sub directory ; otherwise loops thru all subdirectories
# find each directory under application
# if test code exists copy it from sub-dir in prep for running it
if [ -n "$1" ] ; then
  parent_directory="$APPLICATION_DIR"/"$1/"
else
  parent_directory="$APPLICATION_DIR/*/"
fi
for path in $parent_directory ; do
    dirs=$(echo "$path" | tr "\/" '\n')
    for dir in $dirs
        do
            if ! [ "$dir" == $APPLICATION_DIR ] ; then
                if [ -d $APPLICATION_DIR/"$dir/test" ]; then
                    echo "Preparing tests for $dir"
                    # copy util code but not the test code
                    rsync -av --exclude='test/' $APPLICATION_UTIL_DIR/* $APPLICATION_DIR/"$dir"
                    echo "Running tests for $dir"
                    pip install -r $APPLICATION_DIR/"$dir"/test/requirements.txt
                    coverage run -a --source=$APPLICATION_DIR/"$dir"  -m pytest $APPLICATION_DIR/"$dir"
                else
                    echo "No tests written for $dir"
                fi
            fi
        done
done

# test utils if we are not targetting specific subfolder
if [ -z "$1" ] ; then
  for path in "$APPLICATION_UTIL_DIR"/*/ ; do
      dirs=$(echo "$path" | tr "\/" '\n')
      for dir in $dirs
          do
              if ! [ "$dir" == $APPLICATION_UTIL_DIR ] ; then
                  if [ -d $APPLICATION_UTIL_DIR/"$dir/test" ]; then
                      echo "Preparing tests for $dir"
                      echo "Running tests for $dir"
                      pip install -r $APPLICATION_UTIL_DIR/"$dir"/test/requirements.txt
                      coverage run -a --source=$APPLICATION_UTIL_DIR/"$dir" -m pytest $APPLICATION_UTIL_DIR/"$dir"
                  else
                      echo "No tests written for $dir"
                  fi
              fi
          done
  done
fi

#  use requirements defined for tests/unit
coverage report
coverage html
coverage xml

# now clear down copied test code after testing
echo "Removing temporary files"
for path in "$APPLICATION_DIR"/*/ ; do
    dirs=$(echo "$path" | tr "\/" '\n')
    for dir in $dirs
        do
            if [ -d $APPLICATION_DIR/"$dir"/test/ ]; then
                echo "Clearing down temp test files for $dir"
                rm -rf $APPLICATION_DIR/"$dir"/common
            fi
        done
done
