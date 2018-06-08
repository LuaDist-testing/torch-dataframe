#!/bin/bash

echo "+++++++++++++++++++++++++++++++";
echo "+ Start torch-dataframe tests +";
echo "+++++++++++++++++++++++++++++++";
echo "";

var=0
count=0
for f in *_tests.lua; do
    echo "";
    echo "********************************************";
    echo "Running tests in $f";
    lua $f;
    var=$(($var+$?))
    count=$(($count+1))
    echo "End $f";
    echo "********************************************";
done

echo ""
echo "=============================================="
echo "Number of scripts failed: $var (total scripts: $count)"
echo "=============================================="
exit $var