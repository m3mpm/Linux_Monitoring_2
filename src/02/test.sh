#!/bin/bash

date_run_script=$(date +%d%m%y)
dir_name="dir_test"
fname="fil_name"
file_ext="txt"
file_size="100Mb"

mkdir $dir_name
file_check="$(pwd)/$dir_name/$fname""_$date_run_script.$file_ext"
fallocate -l $file_size "$(pwd)/$dir_name/$fname""_$date_run_script.$file_ext"
if [[ $? -eq 0 ]]
then
    echo $?
    echo "Success"
else
    echo $?
    echo "Fail"
fi
