#!/bin/bash
set -x
for piaidixvfb in $(ps aux | grep "Xvfb" | awk '{print $2}'); do sudo kill -9 $piaidixvfb; done > /dev/null
for piaidiodoo in $(ps aux | grep "arin" | awk '{print $2}'); do sudo kill -9 $piaidiodoo; done > /dev/null 
