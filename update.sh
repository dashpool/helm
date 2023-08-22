#!/bin/bash

helm package .

cp dashpool-*.tgz ./charts
rm -f dashpool-*.tgz

helm repo index ./charts

