#!/bin/bash

helm package .

current_dir=$(pwd)
charts_dir="./charts"

# Check if the file exists in the charts directory with the same name
for tgz_file in dashpool-*.tgz; do
    if [ -e "$charts_dir/$tgz_file" ]; then
        echo "Version $tgz_file already exists"
        echo "Create a new version?"
        rm -f $tgz_file
        exit 1
    fi
done

cp dashpool-*.tgz ./charts
rm -f dashpool-*.tgz

# create a copy of the ./charts/index.yaml
cp ./charts/index.yaml ./index-old.yaml

helm repo index ./charts

# update the timestamps in the new index.yaml
python3 ./update.py

rm -f ./index-old.yaml

