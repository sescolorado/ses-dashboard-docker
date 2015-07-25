#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage $0 <ses-dashboard application directory>"
	exit 1
fi

if [ ! -d $1 ]; then
	echo "No ses-dashboard application directory specified."
	exit 1
fi

./mysql/run.sh
./app/run_prod.sh $1
