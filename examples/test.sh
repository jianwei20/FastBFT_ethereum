#!/bin/bash


for entry in `ls newkey/keystore  $search_dir`; do
     node getPrivatekey1.js $entry
done
