#!/bin/bash 

if [ -z "$1" ]
then
  echo "Workload name must be supplied."
  exit 1
fi

if [ -z "$2" ]
then
  echo "Environment (N or P) must be supplied."
  exit 1
fi

WORKLOAD_STACK="elz-workload-$2-$1" 

echo "Creating $WORKLOAD_STACK" 

rm -rf $WORKLOAD_STACK
cp -a "elz-workload" $WORKLOAD_STACK

rm -f $WORKLOAD_STACK/providers.tf
cp $WORKLOAD_STACK/providers.standalone $WORKLOAD_STACK/providers.tf

