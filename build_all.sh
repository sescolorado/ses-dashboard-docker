#!/bin/bash

cd base
./build.sh

cd ..

cd app
./build.sh

cd ..

cd mysql
./build.sh
